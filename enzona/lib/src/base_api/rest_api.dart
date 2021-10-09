import 'dart:io';

import 'package:chopper/chopper.dart' as chopper;
import 'package:enzona/src/base_api/adept_chopper_client.dart';
import 'package:enzona/src/base_api/dio_oauth2_client.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';

final restAPI = RestAPI();

class RestAPI {
  Dio dio = Dio();

  HttpClient? httpClient;
  http.Client? baseClient;
  DioOauth2Client? dioOauth2Client;

  CustomChopperClient chopperClient = CustomChopperClient();
  chopper.Converter? converter;
  final Map<Type, chopper.ChopperService> _services = {};

  Duration? timeout;
  String? apiProtocol;
  String? apiHost;
  String? apiPort;
  late String apiUrl;

  RestAPI() {
    apiProtocol = "http://";
    apiHost = "www.api.com";
    apiPort = "8080";
    apiUrl = apiProtocol! + apiHost! + apiPort!;
  }

  void init({String? apiUrl, Duration? timeout, HttpClient? httpClient, http.Client? baseClient, DioOauth2Client? dioOauth2Client}) {
    if ((apiUrl?.isNotEmpty ?? true)) updateApiUrl(apiUrl: apiUrl);
    if (timeout != null) this.timeout = timeout;
    if (httpClient != null) this.httpClient = httpClient;
    if (baseClient != null) this.baseClient = baseClient;
    if (dioOauth2Client != null) this.dioOauth2Client = dioOauth2Client;

    initChopper();
    initDio();
  }

  void initChopper() {
    try {
      chopperClient.dispose();
    } catch (e) {
      print(e);
    }
    converter ??= chopper.JsonConverter();
    chopperClient = CustomChopperClient(
      baseUrl: apiUrl,
      client: baseClient,
      services: _services.values,
      converter: converter,
      timeout: timeout,
    );
    _initServices();
  }

  void initDio() {
    try {
      dio.close(force: true);
    } catch (e) {
      print(e);
    }
    dio = Dio(
      BaseOptions(
        baseUrl: apiUrl,
        connectTimeout: timeout?.inMilliseconds
      )
    );

    if(dioOauth2Client != null) {
      // Add auth token to each request
      dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
        if(dioOauth2Client!.credentials.isExpired) {
          dioOauth2Client = await dioOauth2Client!.refreshCredentials();
        }
        options.headers.addAll({
          HttpHeaders.authorizationHeader: "Bearer ${dioOauth2Client!.credentials.accessToken}",
          HttpHeaders.contentTypeHeader: Headers.jsonContentType,
        });
        return handler.next(options);
      }));
    }

    if(httpClient != null) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate  = (client) {
        return httpClient;
      };
    }
  }

  void _initServices() {
    _services.forEach((type, service) {
      service.client = chopperClient;
    });
  }

  void dispose() {
    try {
      // _services.forEach((t, s) => s.dispose()); // ChopperService no longer support .dispose()
      _services.clear();
      chopperClient.dispose();
    } catch (e) {
      print(e);
    }
  }

  void addService(chopper.ChopperService service) {
    service.client = chopperClient;
    _services[service.definitionType] = service;
  }

  T service<T extends chopper.ChopperService>(Type type) {
    final s = _services[type];
    if (s == null) {
      throw Exception("Service of type '$type' not found.");
    }
    return s as T;
  }

  void updateApiUrl(
      {String? apiUrl, String? apiProtocol, String? apiHost, String? apiPort}) {
    if (apiUrl?.isEmpty ?? false) {
      this.apiProtocol = apiProtocol ?? this.apiProtocol;
      this.apiHost = apiHost ?? this.apiHost;
      this.apiPort = apiPort ?? this.apiPort;
      this.apiUrl = apiProtocol! + apiHost! + apiPort!;
    } else {
      this.apiUrl = apiUrl!;
    }
  }
}
