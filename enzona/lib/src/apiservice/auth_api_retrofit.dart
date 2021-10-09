
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:enzona/enzona.dart';
import 'package:enzona/src/apiservice/auth_api.dart';
import 'package:enzona/src/base_api/rest_api.dart' as rest_api;
import 'package:enzona/src/service/auth_service_retrofit.dart';
import 'package:http/http.dart' as http;

class AuthAPIRetrofit extends AuthAPI<AuthServiceRetrofit, Payment> {

  AuthAPIRetrofit({Dio? dio}) : super(AuthServiceRetrofit(dio ?? rest_api.restAPI.dio), dataType: Payment());

  @override
  Future<http.Response> authenticate({
    required String authorization,
    required String grantType,
    required String consumerKey,
    required String consumerSecret,
    required String scope,
  }) async {
    final dioResponse = (await service.authenticate(
      authorization: authorization,
      grantType: grantType,
      // consumerKey: consumerKey,
      // consumerSecret: consumerSecret,
      scope: scope,
    )).response;
    return http.Response(
      dioResponse.data,
      dioResponse.statusCode ?? HttpStatus.notFound,
      headers: dioResponse.headers.map.map((key, value) => MapEntry(key, value.join('; '))),
      isRedirect: dioResponse.isRedirect ?? false,
      request: http.Request(
        dioResponse.requestOptions.method,
        dioResponse.requestOptions.uri,
      ),
    );
  }
}