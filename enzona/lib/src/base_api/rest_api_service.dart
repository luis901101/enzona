import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:enzona/src/base_api/base_authorization_api.dart';
import 'package:enzona/src/base_api/rest_api.dart' as rest_api;
import 'package:enzona/src/entity/pagination.dart';
import 'package:enzona/src/utils/jsonable.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

abstract class RestAPIService<I, DataType extends Jsonable, ErrorType> with BaseAuthorizationAPI implements ChopperService {

  static const authorizationKey = "Authorization";

  static const Map<String, String> defaultHeaders = {
  };

  I service;
  DataType? dataType;
  ErrorType? errorType;
  rest_api.RestAPI restAPI;

  RestAPIService(
    this.service, {
    this.dataType,
    this.errorType,
    rest_api.RestAPI? restAPI,
  }) : restAPI = restAPI ?? rest_api.restAPI {
    if(service is ChopperService) {
      this.restAPI.addService(service as ChopperService);
    }
  }

  void updateHttpClient(http.Client httpClient) {
    restAPI.init(baseClient: httpClient);
  }

  Object? parseError(Response response) {
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

  Future<Response> getSaveResponse(Future<Response> futureResponse) async {
    Response response;
    try {
      response = await futureResponse;
    } catch (e) {
      if (e is Response) {
        response = e;
      } else {
        rethrow;
      }
    }
    return response;
  }

  Future<Response<DataType>> parseResponse(Future<Response> futureResponse) async {
    return genericParseResponse(futureResponse, dataType: dataType);
  }

  Future<Response<List<DataType>>> parseResponseAsList(
      Future<Response> futureResponse) async {
    return genericParseResponseAsList(futureResponse, dataType: dataType);
  }

  Future<Response<List<DataType>>> parsePaginationResponseAsList(
      Future<Response> futureResponse, {required String dataListParam}) async {
    return genericParsePaginationResponseAsList(futureResponse, dataType: dataType, dataListParam: dataListParam);
  }

  Future<Response<DataTypeGeneric>> genericParseResponse<DataTypeGeneric extends Jsonable?>(
      Future<Response> futureResponse, {DataTypeGeneric? dataType}) async {
    Response response = await getSaveResponse(futureResponse);
    try {
      if (dataType != null) {
        DataTypeGeneric? dataTypeResult = response.body is String
            ? dataType.fromJsonString(response.body) as DataTypeGeneric?
            : dataType.fromJsonMap(response.body) as DataTypeGeneric?;
        Object? errorTypeResult = parseError(response);
        return Response<DataTypeGeneric>(response.base, dataTypeResult,
            error: errorTypeResult);
      }
    } catch (e) {
      String message = e.toString();
      response = Response(
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
    return Response<DataTypeGeneric>(response.base, null, error: response.error);
  }

  Future<Response<List<DataTypeGeneric>>>
      genericParseResponseAsList<DataTypeGeneric extends Jsonable?>(
          Future<Response> futureResponse, {DataTypeGeneric? dataType}) async {
    Response response = await getSaveResponse(futureResponse);
    try {
      if (dataType != null) {
        List<DataTypeGeneric>? dataList = response.body is String
            ? dataType.fromJsonStringList(response.body) as List<DataTypeGeneric>?
            : dataType.fromJsonList(response.body) as List<DataTypeGeneric>?;
        Object? errorTypeResult = parseError(response);
        return Response<List<DataTypeGeneric>>(response.base, dataList,
            error: errorTypeResult);
      }
    } catch (e) {
      String message = e.toString();
      response = Response(
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
    return Response<List<DataTypeGeneric>>(response.base, null, error: response.error);
  }

  Future<Response<List<DataTypeGeneric>>>
      genericParsePaginationResponseAsList<DataTypeGeneric extends Jsonable?>(
          Future<Response> futureResponse, {DataTypeGeneric? dataType, required String dataListParam}) async {
    Response response = await getSaveResponse(futureResponse);
    try {
      if (dataType != null) {
        final body = response.body;
        if(body is Map) {
          Pagination pagination = Pagination.fromJson(body[Pagination.paginationParam]);
          response.base.headers[Pagination.totalCountHeader] = pagination.total?.toString() ?? '0';
          List<DataTypeGeneric>? dataList = dataType.fromJsonList(body[dataListParam]) as List<DataTypeGeneric>?;
          Object? errorTypeResult = parseError(response);
          return Response<List<DataTypeGeneric>>(
            response.base,
            dataList,
            error: errorTypeResult
          );
        }
      }
    } catch (e) {
      String message = e.toString();
      response = Response(
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
    return Response<List<DataTypeGeneric>>(response.base, null, error: response.error);
  }

  @override
  Type get definitionType => (service as ChopperService).definitionType;

  @override
  ChopperClient get client => (service as ChopperService).client;

  @override
  set client(ChopperClient client) => (service as ChopperService).client = client;
}
