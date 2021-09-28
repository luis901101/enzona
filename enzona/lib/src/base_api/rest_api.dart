import 'package:chopper/chopper.dart';
import 'package:enzona/src/base_api/adept_chopper_client.dart';
import 'package:http/http.dart' as http;

final restAPI = RestAPI();

class RestAPI {
  http.Client? httpClient;
  CustomChopperClient? chopperClient;
  Converter? converter;
  final Map<Type, ChopperService> _services = {};

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

  void init({String? apiUrl, Duration? timeout, http.Client? httpClient}) {
    if ((apiUrl?.isNotEmpty ?? true)) updateApiUrl(apiUrl: apiUrl);
    if (timeout != null) this.timeout = timeout;
    if (httpClient != null) this.httpClient = httpClient;
    try {
      chopperClient?.dispose();
    } catch (e) {
      print(e);
    }
    converter ??= JsonConverter();
    chopperClient = CustomChopperClient(
      baseUrl: this.apiUrl,
      client: this.httpClient,
      services: _services.values,
      converter: converter,
      timeout: this.timeout,
    );
    _initServices();
  }

  void _initServices() {
    _services.forEach((type, service) {
      service.client = chopperClient!;
    });
  }

  void dispose() {
    try {
      // _services.forEach((t, s) => s.dispose()); // ChopperService no longer support .dispose()
      _services.clear();
      chopperClient?.dispose();
    } catch (e) {
      print(e);
    }
  }

  void addService(ChopperService service) {
    service.client = chopperClient!;
    _services[service.definitionType] = service;
  }

  T service<T extends ChopperService>(Type type) {
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
