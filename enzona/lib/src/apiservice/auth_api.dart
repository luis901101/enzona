
import 'package:enzona/src/base_api/rest_api_service.dart';
import 'package:enzona/src/entity/error_response.dart';
import 'package:enzona/src/utils/jsonable.dart';
import 'package:http/http.dart' as http;

abstract class AuthAPI<I, DataType extends Jsonable> extends RestAPIService<I, DataType, ErrorResponse> {

  AuthAPI(I service, {required DataType dataType}) : super(service, dataType: dataType, errorType: ErrorResponse());

  Future<http.Response> authenticate({
    required String authorization,
    required String grantType,
    required String consumerKey,
    required String consumerSecret,
    required String scope,
  });
}