// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:dio/adapter.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:oauth2/oauth2.dart';

class DioOauth2Client {
  /// The client identifier for this client.
  ///
  /// The authorization server will issue each client a separate client
  /// identifier and secret, which allows the server to tell which client is
  /// accessing it. Some servers may also have an anonymous identifier/secret
  /// pair that any client may use.
  ///
  /// This is usually global to the program using this library.
  final String? identifier;

  /// The client secret for this client.
  ///
  /// The authorization server will issue each client a separate client
  /// identifier and secret, which allows the server to tell which client is
  /// accessing it. Some servers may also have an anonymous identifier/secret
  /// pair that any client may use.
  ///
  /// This is usually global to the program using this library.
  ///
  /// Note that clients whose source code or binary executable is readily
  /// available may not be able to make sure the client secret is kept a secret.
  /// This is fine; OAuth2 servers generally won't rely on knowing with
  /// certainty that a client is who it claims to be.
  final String? secret;

  /// The credentials this client uses to prove to the resource server that it's
  /// authorized.
  ///
  /// This may change from request to request as the credentials expire and the
  /// client refreshes them automatically.
  Credentials get credentials => _credentials;
  Credentials _credentials;

  /// Callback to be invoked whenever the credentials refreshed.
  final CredentialsRefreshedCallback? _onCredentialsRefreshed;

  /// Whether to use HTTP Basic authentication for authorizing the client.
  final bool _basicAuth;

  /// The underlying HTTP client.
  final HttpClient? _httpClient;

  /// Creates a new client from a pre-existing set of credentials.
  ///
  /// When authorizing a client for the first time, you should use
  /// [AuthorizationCodeGrant] or [resourceOwnerPasswordGrant] instead of
  /// constructing a [Client] directly.
  ///
  /// [httpClient] is the underlying client that this forwards requests to after
  /// adding authorization credentials to them.
  ///
  /// Throws an [ArgumentError] if [secret] is passed without [identifier].
  DioOauth2Client(this._credentials,
      {this.identifier,
      this.secret,
      CredentialsRefreshedCallback? onCredentialsRefreshed,
      bool basicAuth = true,
      HttpClient? httpClient})
      : _basicAuth = basicAuth,
        _onCredentialsRefreshed = onCredentialsRefreshed,
        _httpClient = httpClient {
    if (identifier == null && secret != null) {
      throw ArgumentError('secret may not be passed without identifier.');
    }
  }

  /// always return true because credentials refresh will be managed anyway
  /// on refreshCredentials function.
  bool get canRefresh => true;

  /// A [Future] used to track whether [refreshCredentials] is running.
  Future<Credentials>? _refreshingFuture;

  /// Explicitly refreshes this client's credentials. Returns this client.
  ///
  /// This will throw a [StateError] if the [Credentials] can't be refreshed, an
  /// [AuthorizationException] if refreshing the credentials fails, or a
  /// [FormatError] if the authorization server returns invalid responses.
  ///
  /// You may request different scopes than the default by passing in
  /// [newScopes]. These must be a subset of the scopes in the
  /// [Credentials.scopes] field of [Client.credentials].
  Future<DioOauth2Client> refreshCredentials([List<String>? newScopes]) async {
    if (!canRefresh) {
      var prefix = 'OAuth credentials';
      if (credentials.isExpired) prefix = '$prefix have expired and';
      throw StateError("$prefix can't be refreshed.");
    }

    // To make sure that only one refresh happens when credentials are expired
    // we track it using the [_refreshingFuture]. And also make sure that the
    // _onCredentialsRefreshed callback is only called once.
    if (_refreshingFuture == null) {
      try {
        if(/*credentials.canRefresh*/ false) {
          ///Fixme: implement credentials refresh using Dio
          _refreshingFuture = credentials.refresh(
            identifier: identifier,
            secret: secret,
            newScopes: newScopes,
            basicAuth: _basicAuth,
            // httpClient: _httpClient,
          );
        } else { /// Here a new clientCredentialsGrant is forced to get new credentials with new expiration date
          final client = await clientCredentialsGrant(
            credentials.tokenEndpoint!,
            identifier,
            secret,
            scopes: newScopes ?? credentials.scopes,
            httpClient: _httpClient,
          );
          _refreshingFuture = Future.value(client.credentials);
        }
        _credentials = await _refreshingFuture!;
        _onCredentialsRefreshed?.call(_credentials);
      } finally {
        _refreshingFuture = null;
      }
    } else {
      await _refreshingFuture;
    }

    return this;
  }

  /// Adds additional query parameters to [url], overwriting the original
  /// parameters if a name conflict occurs.
  static Uri addQueryParameters(Uri url, Map<String, String> parameters) => url.replace(
      queryParameters: Map.from(url.queryParameters)..addAll(parameters));

  static String basicAuthHeader(String identifier, String secret) {
    var userPass = Uri.encodeFull(identifier) + ':' + Uri.encodeFull(secret);
    return 'Basic ' + base64Encode(ascii.encode(userPass));
  }

  static Future<DioOauth2Client> clientCredentialsGrant(
      Uri authorizationEndpoint, String? identifier, String? secret,
      {Iterable<String>? scopes,
        bool basicAuth = true,
        HttpClient? httpClient,
        String? delimiter,
        Map<String, dynamic> Function(MediaType? contentType, String body)?
        getParameters}) async {
    delimiter ??= ' ';
    var startTime = DateTime.now();

    var body = {'grant_type': 'client_credentials'};

    var headers = <String, String>{};

    if (identifier != null) {
      if (basicAuth) {
        headers['Authorization'] = basicAuthHeader(identifier, secret!);
      } else {
        body['client_id'] = identifier;
        if (secret != null) body['client_secret'] = secret;
      }
    }

    if (scopes != null && scopes.isNotEmpty) {
      body['scope'] = scopes.join(delimiter);
    }

    final dio = Dio();
    if(httpClient != null) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate  = (client) {
        return httpClient;
      };
    }

    var dioResponse = await dio.postUri(
      authorizationEndpoint,
      data: body,
      options: Options(
        headers: headers,
        responseType: ResponseType.plain,
        contentType: 'application/x-www-form-urlencoded',
      ),
    );
    // dio.close(force: true);

    var credentials = handleAccessTokenResponse(
      http.Response(
        dioResponse.data,
        dioResponse.statusCode ?? HttpStatus.notFound,
        headers: dioResponse.headers.map.map((key, value) => MapEntry(key, value.join('; '))),
        isRedirect: dioResponse.isRedirect ?? false,
        request: http.Request(
          dioResponse.requestOptions.method,
          dioResponse.requestOptions.uri,
        ),
      ),
      authorizationEndpoint, startTime, scopes?.toList() ?? [], delimiter,
      getParameters: getParameters
    );

    return DioOauth2Client(credentials,
        identifier: identifier, secret: secret, httpClient: httpClient);
  }

  static Credentials handleAccessTokenResponse(http.Response response, Uri tokenEndpoint,
      DateTime startTime, List<String>? scopes, String delimiter,
      {Map<String, dynamic> Function(MediaType? contentType, String body)?
      getParameters}) {
    getParameters ??= parseJsonParameters;

    try {
      if (response.statusCode != 200) {
        _handleErrorResponse(response, tokenEndpoint, getParameters);
      }

      var contentTypeString = response.headers['content-type'];
      if (contentTypeString == null) {
        throw FormatException('Missing Content-Type string.');
      }

      var parameters =
      getParameters(MediaType.parse(contentTypeString), response.body);

      for (var requiredParameter in ['access_token', 'token_type']) {
        if (!parameters.containsKey(requiredParameter)) {
          throw FormatException(
              'did not contain required parameter "$requiredParameter"');
        } else if (parameters[requiredParameter] is! String) {
          throw FormatException(
              'required parameter "$requiredParameter" was not a string, was '
                  '"${parameters[requiredParameter]}"');
        }
      }

      if (parameters['token_type'].toLowerCase() != 'bearer') {
        throw FormatException(
            '"$tokenEndpoint": unknown token type "${parameters['token_type']}"');
      }

      var expiresIn = parameters['expires_in'];
      if (expiresIn != null && expiresIn is! int) {
        throw FormatException(
            'parameter "expires_in" was not an int, was "$expiresIn"');
      }

      for (var name in ['refresh_token', 'id_token', 'scope']) {
        var value = parameters[name];
        if (value != null && value is! String) {
          throw FormatException(
              'parameter "$name" was not a string, was "$value"');
        }
      }

      var scope = parameters['scope'] as String?;
      if (scope != null) scopes = scope.split(delimiter);

      var expiration = expiresIn == null
          ? null
          : startTime.add(Duration(seconds: expiresIn) - _expirationGrace);

      return Credentials(parameters['access_token'],
          refreshToken: parameters['refresh_token'],
          idToken: parameters['id_token'],
          tokenEndpoint: tokenEndpoint,
          scopes: scopes,
          expiration: expiration);
    } on FormatException catch (e) {
      throw FormatException('Invalid OAuth response for "$tokenEndpoint": '
          '${e.message}.\n\n${response.body}');
    }
  }

  /// Throws the appropriate exception for an error response from the
  /// authorization server.
  static void _handleErrorResponse(
      http.Response response, Uri tokenEndpoint, GetParameters getParameters) {
    // OAuth2 mandates a 400 or 401 response code for access token error
    // responses. If it's not a 400 reponse, the server is either broken or
    // off-spec.
    if (response.statusCode != 400 && response.statusCode != 401) {
      var reason = '';
      var reasonPhrase = response.reasonPhrase;
      if (reasonPhrase != null && reasonPhrase.isNotEmpty) {
        reason = ' $reasonPhrase';
      }
      throw FormatException('OAuth request for "$tokenEndpoint" failed '
          'with status ${response.statusCode}$reason.\n\n${response.body}');
    }

    var contentTypeString = response.headers['content-type'];
    var contentType =
    contentTypeString == null ? null : MediaType.parse(contentTypeString);

    var parameters = getParameters(contentType, response.body);

    if (!parameters.containsKey('error')) {
      throw FormatException('did not contain required parameter "error"');
    } else if (parameters['error'] is! String) {
      throw FormatException('required parameter "error" was not a string, was '
          '"${parameters["error"]}"');
    }

    for (var name in ['error_description', 'error_uri']) {
      var value = parameters[name];

      if (value != null && value is! String) {
        throw FormatException('parameter "$name" was not a string, was "$value"');
      }
    }

    var description = parameters['error_description'];
    var uriString = parameters['error_uri'];
    var uri = uriString == null ? null : Uri.parse(uriString);
    throw AuthorizationException(parameters['error'], description, uri);
  }

  /// Parses parameters from a response with a JSON body, as per the [OAuth2
  /// spec][].
  ///
  /// [OAuth2 spec]: https://tools.ietf.org/html/rfc6749#section-5.1
  static Map<String, dynamic> parseJsonParameters(MediaType? contentType, String body) {
    // The spec requires a content-type of application/json, but some endpoints
    // (e.g. Dropbox) serve it as text/javascript instead.
    if (contentType == null ||
        (contentType.mimeType != 'application/json' &&
            contentType.mimeType != 'text/javascript')) {
      throw FormatException(
          'Content-Type was "$contentType", expected "application/json"');
    }

    var untypedParameters = jsonDecode(body);
    if (untypedParameters is Map<String, dynamic>) {
      return untypedParameters;
    }

    throw FormatException('Parameters must be a map, was "$untypedParameters"');
  }

}

/// The amount of time to add as a "grace period" for credential expiration.
///
/// This allows credential expiration checks to remain valid for a reasonable
/// amount of time.
const _expirationGrace = Duration(seconds: 10);

/// The type of a callback that parses parameters from an HTTP response.
typedef GetParameters = Map<String, dynamic> Function(
    MediaType? contentType, String body);
