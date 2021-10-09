library enzona;

import 'dart:io';
import 'package:enzona/src/apiservice/payment_api.dart';
import 'package:enzona/src/apiservice/payment_api_retrofit.dart';
import 'package:enzona/src/base_api/dio_oauth2_client.dart';
import 'package:enzona/src/utils/platofrm_utils.dart';

import 'package:enzona/src/apiservice/payment_api_chopper.dart';
import 'package:enzona/src/base_api/custom_oauth2_client.dart';
import 'package:enzona/src/base_api/rest_api.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

export 'package:enzona/src/apiservice/payment_api_chopper.dart';

export 'package:enzona/src/entity/error_response.dart';
export 'package:enzona/src/entity/pagination.dart';
export 'package:enzona/src/entity/payment.dart';
export 'package:enzona/src/entity/payment_amount.dart';
export 'package:enzona/src/entity/payment_amount_details.dart';
export 'package:enzona/src/entity/payment_item.dart';
export 'package:enzona/src/entity/payment_link.dart';
export 'package:enzona/src/entity/payment_request.dart';
export 'package:enzona/src/entity/refund.dart';
export 'package:enzona/src/base_api/e_response.dart';

export 'package:enzona/src/enumerator/status_code.dart';

/// CORS configurations from API prevents requests from unauthorized web clients
class Enzona {
  final String apiUrl;
  final String accessTokenUrl;
  final String consumerKey;
  final String consumerSecret;
  final List<String> scopes;
  final Duration? timeout;
  /// Set this if you need control over http requests like validating certificates and so.
  /// Not supported in Web
  final HttpClient? httpClient;
  /// OAuth2 Client for authorization API requests
  late final CustomOauth2Client oauth2Client;
  /// Enzona Payment API
  late final PaymentAPI paymentAPI;
  bool _initialized = false;

  Enzona({
    required this.apiUrl,
    required this.accessTokenUrl,
    required this.consumerKey,
    required this.consumerSecret,
    required this.scopes,
    this.timeout,
    HttpClient? httpClient,
  }) : httpClient = PlatformUtils.isWeb ? null : (httpClient ?? (HttpClient()..badCertificateCallback =
        (X509Certificate cert, String host, int port) =>
          host == 'apisandbox.enzona.net' || host == 'api.enzona.net'));

  bool get isInitialized => _initialized;

  oauth2.Credentials get credentials => oauth2Client.credentials;
  Future<oauth2.Credentials> refreshCredentials() async {
    await oauth2Client.refreshCredentials();
    return credentials;
  }

  /// Call this function before using Enzona APIs
  Future<void> init() async {
    if(isInitialized) return;

    /// Oauth2 httpClient does token refresh automatically, but due to the lack
    /// of a proper refresh token implementation from Enzona API the token refresh
    /// should be done as new clientCredentialsGrant.
    /// CustomOauth2Client is a wrapper that does exactly the same as official
    /// Oauth2 Client but in addition it ensures token refresh by doing a
    /// clientCredentialsGrant.

    http.Client? baseClient;
    if(!PlatformUtils.isWeb) {
      baseClient = IOClient(httpClient);
    }
    oauth2Client = CustomOauth2Client.fromOauth2Client(
      await oauth2.clientCredentialsGrant(
        Uri.parse(accessTokenUrl),
        consumerKey,
        consumerSecret,
        scopes: scopes,
        httpClient: baseClient,
      ),
      httpClient: baseClient,
    );

    // oauth2Client = CustomOauth2Client(
    //   oauth2.Credentials(
    //     '1c50c1ef-a6e4-3cb2-9be0-b227b04e88b9',
    //     scopes: scopes,
    //   ),
    //   identifier: consumerKey,
    //   secret: consumerSecret,
    //   httpClient: baseClient,
    // );

    restAPI.init(
      baseClient: oauth2Client,
      httpClient: httpClient,
      apiUrl: apiUrl,
      timeout: timeout,
    );

    paymentAPI = PaymentAPIChopper();
    _initialized = true;
  }
}

class EnzonaRetrofit extends Enzona {
  late final DioOauth2Client dioOauth2Client;

  EnzonaRetrofit({
    required String apiUrl,
    required String accessTokenUrl,
    required String consumerKey,
    required String consumerSecret,
    required List<String> scopes,
    Duration? timeout,
    HttpClient? httpClient,
  }) : super(
    apiUrl: apiUrl,
    accessTokenUrl: accessTokenUrl,
    consumerKey: consumerKey,
    consumerSecret: consumerSecret,
    scopes: scopes,
    timeout: timeout,
    httpClient: httpClient,
  );

  @override
  oauth2.Credentials get credentials => dioOauth2Client.credentials;
  @override
  Future<oauth2.Credentials> refreshCredentials() async {
    await dioOauth2Client.refreshCredentials();
    return credentials;
  }

  @override
  Future<void> init() async {
    if(isInitialized) return;

    dioOauth2Client = await DioOauth2Client.clientCredentialsGrant(
      Uri.parse(accessTokenUrl),
      consumerKey,
      consumerSecret,
      scopes: scopes,
      httpClient: httpClient,
    );

    // dioOauth2Client = DioOauth2Client(
    //   oauth2.Credentials(
    //     '1c50c1ef-a6e4-3cb2-9be0-b227b04e88b9',
    //     scopes: scopes,
    //   ),
    //   identifier: consumerKey,
    //   secret: consumerSecret,
    //   httpClient: httpClient,
    // );

    restAPI.init(
      httpClient: httpClient,
      dioOauth2Client: dioOauth2Client,
      apiUrl: apiUrl,
      timeout: timeout,
    );

    paymentAPI = PaymentAPIRetrofit();
    _initialized = true;
  }
}
