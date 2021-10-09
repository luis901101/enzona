

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'auth_service_retrofit.g.dart';

@RestApi()
abstract class AuthServiceRetrofit {
  factory AuthServiceRetrofit(Dio dio, {String? baseUrl}) = _AuthServiceRetrofit;

  @POST('')
  @FormUrlEncoded()
  Future<HttpResponse<String>> authenticate({
    @Header('Authorization') required String authorization,
    @Field('grant_type') required String grantType,
    // @Field('client_id') required String consumerKey,
    // @Field('client_secret') required String consumerSecret,
    @Field('scope') required String scope,
  });
}