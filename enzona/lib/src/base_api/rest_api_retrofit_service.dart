import 'dart:convert';
import 'dart:io';

import 'package:chopper/chopper.dart' as chopper;
import 'package:retrofit/retrofit.dart' as retrofit;
import 'package:dio/dio.dart' as dio;
import 'package:enzona/src/base_api/base_authorization_api.dart';
import 'package:enzona/src/base_api/enzona_response.dart';
import 'package:enzona/src/base_api/rest_api.dart' as rest_api;
import 'package:enzona/src/entity/pagination.dart';
import 'package:enzona/src/utils/jsonable.dart';
import 'package:http/http.dart' as http;
import 'dart:async';


abstract class RestAPIRetrofitService<I, DataType extends Jsonable, ErrorType> with BaseAuthorizationAPI implements chopper.ChopperService {

  static const authorizationKey = "Authorization";

  static const Map<String, String> defaultHeaders = {
  };

  I service;
  DataType? dataType;
  ErrorType? errorType;
  rest_api.RestAPI restAPI;

  RestAPIRetrofitService(
    this.service, {
    this.dataType,
    this.errorType,
    rest_api.RestAPI? restAPI,
  }) : restAPI = restAPI ?? rest_api.restAPI {
    if(service is chopper.ChopperService) {
      this.restAPI.addService(service as chopper.ChopperService);
    }
  }

  void updateHttpClient(http.Client httpClient) {
    restAPI.init(httpClient: httpClient);
  }

  Object? parseError(EnzonaResponse response) {
    Object? errorTypeResult = response.error;
    try {
      if (errorType is Jsonable) {
        Map? error = response.error is String ? jsonDecode(response.error!.toString()) : response.error;
        errorTypeResult = (errorType as Jsonable).fromJsonMap(error?['fault']);
      }
    } catch (e) {
      print(e);
    }
    return errorTypeResult;
  }

  Future<EnzonaResponse> getSaveResponse(Future futureResponse) async {
    EnzonaResponse response = EnzonaResponse(
      http.Response('', HttpStatus.notFound),
      null,
    );

    EnzonaResponse chopperResponseToCustomHttpResponse(chopper.Response response) =>
      EnzonaResponse(
        response.base,
        response.body,
        error: response.error,
        extraData: response,
      );

    EnzonaResponse retrofitHttpResponseToCustomHttpResponse(retrofit.HttpResponse response) =>
      EnzonaResponse(
        http.Response(
          '',
          response.response.statusCode ?? HttpStatus.notFound,
          headers: response.response.headers.map.map((key, value) => MapEntry(key, value.join('; '))),
          isRedirect: response.response.isRedirect ?? false,
          request: http.Request(
            response.response.requestOptions.method,
            response.response.requestOptions.uri,
          ),
        ),
        response.data,
        error: response.response.data,
        extraData: response
      );

    EnzonaResponse dioErrorToCustomHttpResponse(dio.DioError error) =>
      EnzonaResponse(
        http.Response(
          '',
          error.response?.statusCode ?? HttpStatus.notFound,
          headers: error.response?.headers.map.map((key, value) => MapEntry(key, value.join('; '))) ?? {},
          isRedirect: error.response?.isRedirect ?? false,
          request: http.Request(
            error.response?.requestOptions.method ?? '',
            error.response?.requestOptions.uri ?? Uri(),
          ),
        ),
        null,
        error: error.response?.data,
        extraData: response
      );

    try {
      if(futureResponse is Future<chopper.Response>) {
        final chopper.Response chopperResponse = await futureResponse;
        response = chopperResponseToCustomHttpResponse(chopperResponse);
      } else
      if(futureResponse is Future<retrofit.HttpResponse>) {
        final retrofit.HttpResponse retrofitHttpResponse = await futureResponse;
        response = retrofitHttpResponseToCustomHttpResponse(retrofitHttpResponse);
      }
    } catch (e) {
      if (e is chopper.Response) {
        response = chopperResponseToCustomHttpResponse(e);
      } else
      if (e is retrofit.HttpResponse) {
        response = retrofitHttpResponseToCustomHttpResponse(e);
      } else
      if (e is dio.DioError) {
        response = dioErrorToCustomHttpResponse(e);
      } else {
        rethrow;
      }
    }
    return response;
  }

  Future<EnzonaResponse<DataType>> parseResponse(Future futureResponse) async {
    return genericParseResponse(futureResponse, dataType: dataType);
  }

  Future<EnzonaResponse<List<DataType>>> parseResponseAsList(
      Future futureResponse) async {
    return genericParseResponseAsList(futureResponse, dataType: dataType);
  }

  Future<EnzonaResponse<List<DataType>>> parsePaginationResponseAsList(
      Future futureResponse, {required String dataListParam}) async {
    return genericParsePaginationResponseAsList(futureResponse, dataType: dataType, dataListParam: dataListParam);
  }

  Future<EnzonaResponse<DataTypeGeneric>> genericParseResponse<DataTypeGeneric extends Jsonable?>(
      Future futureResponse, {DataTypeGeneric? dataType}) async {
    EnzonaResponse response = await getSaveResponse(futureResponse);
    try {
      DataTypeGeneric? dataTypeResult;
      if (dataType != null) {
        if(response.body is DataTypeGeneric) {
          dataTypeResult = response.body;
        } else
        if(response.body is String) {
          dataTypeResult = dataType.fromJsonString(response.body) as DataTypeGeneric?;
        } else
        if(response.body is Map) {
          dataTypeResult = dataType.fromJsonMap(response.body) as DataTypeGeneric?;
        }
      }
      Object? errorTypeResult = parseError(response);
      return EnzonaResponse<DataTypeGeneric>(response.base, dataTypeResult,
          error: errorTypeResult);
    } catch (e) {
      String message = e.toString();
      response = EnzonaResponse(
          http.Response(
            response.body?.toString() ?? '',
            Jsonable.jsonParserError,
            headers: response.base.headers,
            isRedirect: response.base.isRedirect,
            persistentConnection: response.base.persistentConnection,
            reasonPhrase: response.base.reasonPhrase,
            request: response.base.request,
          ),
          response.body,
          error: message);
      print(e);
    }
    return EnzonaResponse<DataTypeGeneric>(response.base, null, error: response.error);
  }

  Future<EnzonaResponse<List<DataTypeGeneric>>>
      genericParseResponseAsList<DataTypeGeneric extends Jsonable?>(
          Future futureResponse, {DataTypeGeneric? dataType}) async {
    EnzonaResponse response = await getSaveResponse(futureResponse);
    try {
      List<DataTypeGeneric>? dataList;
      if (dataType != null) {
        if(response.body is List<DataTypeGeneric>) {
          dataList = response.body;
        } else
        if(response.body is String) {
          dataList = dataType.fromJsonStringList(response.body) as List<DataTypeGeneric>?;
        } else
        if(response.body is Map) {
          dataList = dataType.fromJsonList(response.body) as List<DataTypeGeneric>?;
        }
      }
      Object? errorTypeResult = parseError(response);
      return EnzonaResponse<List<DataTypeGeneric>>(response.base, dataList,
          error: errorTypeResult);
    } catch (e) {
      String message = e.toString();
      response = EnzonaResponse(
          http.Response(
            response.body?.toString() ?? '',
            Jsonable.jsonParserError,
            headers: response.base.headers,
            isRedirect: response.base.isRedirect,
            persistentConnection: response.base.persistentConnection,
            reasonPhrase: response.base.reasonPhrase,
            request: response.base.request,
          ),
          response.body,
          error: message);
      print(e);
    }
    return EnzonaResponse<List<DataTypeGeneric>>(response.base, null, error: response.error);
  }

  Future<EnzonaResponse<List<DataTypeGeneric>>>
      genericParsePaginationResponseAsList<DataTypeGeneric extends Jsonable?>(
          Future futureResponse, {DataTypeGeneric? dataType, required String dataListParam}) async {
    EnzonaResponse response = await getSaveResponse(futureResponse);
    try {
      List<DataTypeGeneric>? dataList;
      if (dataType != null) {
        final body = response.body;
        if(body is Map) {
          Pagination pagination = Pagination.fromJson(body[Pagination.paginationParam]);
          response.base.headers[Pagination.totalCountHeader] = pagination.total?.toString() ?? '0';
          dataList = dataType.fromJsonList(body[dataListParam]) as List<DataTypeGeneric>?;
        }
        Object? errorTypeResult = parseError(response);
        return EnzonaResponse<List<DataTypeGeneric>>(
          response.base,
          dataList,
          error: errorTypeResult
        );
      }
    } catch (e) {
      String message = e.toString();
      response = EnzonaResponse(
        http.Response(
          response.body?.toString() ?? '',
          Jsonable.jsonParserError,
          headers: response.base.headers,
          isRedirect: response.base.isRedirect,
          persistentConnection: response.base.persistentConnection,
          reasonPhrase: response.base.reasonPhrase,
          request: response.base.request,
        ),
        response.body,
        error: message
      );
      print(e);
    }
    return EnzonaResponse<List<DataTypeGeneric>>(response.base, null, error: response.error);
  }

  @override
  Type get definitionType => (service as chopper.ChopperService).definitionType;

  @override
  chopper.ChopperClient get client => (service as chopper.ChopperService).client;

  @override
  set client(chopper.ChopperClient client) => (service as chopper.ChopperService).client = client;
}
