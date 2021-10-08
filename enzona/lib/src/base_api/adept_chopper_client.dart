import 'package:chopper/chopper.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class CustomChopperClient extends ChopperClient {
  Duration? timeout;

  CustomChopperClient({
    baseUrl = '',
    http.Client? client,
    Iterable interceptors = const [],
    Converter? converter,
    ErrorConverter? errorConverter,
    Iterable<ChopperService> services = const [],
    this.timeout,
  }) : super(
            baseUrl: baseUrl,
            client: client,
            interceptors: interceptors,
            converter: converter,
            errorConverter: errorConverter,
            services: services);

  @override
  Future<Response<Body>> send<Body, ToDecode>(
    Request request, {
    ConvertRequest? requestConverter,
    ConvertResponse? responseConverter,
  }) async {
    final Future<Response<Body>> response = super.send(request,
        requestConverter: requestConverter,
        responseConverter: responseConverter);
    return timeout != null ? response.timeout(timeout!) : response;
  }
}
