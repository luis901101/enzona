
import 'package:chopper/chopper.dart';
import 'package:enzona/src/base_api/base_authorization_api.dart';
import 'package:enzona/src/base_api/rest_api.dart';
import 'package:enzona/src/base_api/rest_api_service.dart';
import 'package:enzona/src/utils/jsonable.dart';


abstract class APIService<I extends ChopperService, DataType extends Jsonable> extends RestAPIService<I, DataType, DataType> with BaseAuthorizationAPI {

  static const authorizationKey = "Authorization";

  static const Map<String, String> defaultHeaders = {
  };

  APIService(
      I service,
      DataType dataType, {
      RestAPI? customRestAPI,
      }) :
        super(
          service,
          dataType: dataType,
          restAPI: customRestAPI ?? restAPI
      );

}