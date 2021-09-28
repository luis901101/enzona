import 'package:chopper/chopper.dart';
import 'package:enzona/src/base_api/rest_api.dart' as rest_api;
import 'package:enzona/src/utils/jsonable.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

abstract class RestAPIService<I extends ChopperService,
    DataType extends Jsonable, ErrorType> implements ChopperService {
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
    this.restAPI.addService(service);
  }

  dynamic getAuthorization();

  updateHttpClient(http.Client httpClient) {
    restAPI.init(httpClient: httpClient);
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

  Future<Response<DataType>> parseResponse(
      Future<Response> futureResponse) async {
    return genericParseResponse(futureResponse, dataType);
  }

  Future<Response<List<DataType>>> parseResponseAsList(
      Future<Response> futureResponse) async {
    return genericParseResponseAsList(futureResponse, dataType);
  }

  Object? parseError(Response response) {
    Object? errorTypeResult = response.error;
    try {
      if (errorType is Jsonable) {
        errorTypeResult = response.error is String
            ? (errorType as Jsonable).fromJsonString(response.error?.toString())
            : (errorType as Jsonable)
                .fromJsonMap(response.error as Map<String, dynamic>?);
      }
    } catch (e) {
      print(e);
    }
    return errorTypeResult;
  }

  Future<Response<DataTypeGeneric>> genericParseResponse<DataTypeGeneric extends Jsonable?>(
      Future<Response> futureResponse, DataTypeGeneric? dataType) async {
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
          Future<Response> futureResponse, DataTypeGeneric? dataType) async {
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

  // @override
  // void dispose() => service.dispose(); // ChopperService no longer support .dispose()

  @override
  Type get definitionType => service.definitionType;

  @override
  ChopperClient get client => service.client;

  @override
  set client(ChopperClient client) => service.client = client;
}
