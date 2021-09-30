

abstract class BaseAuthorizationAPI
{

  /// No need to use this implementation because Oauth2 HttpClient is used directly on every api request
  /// Check the Enzona init() function.
  // Future<String> getAuthorization() async => getTokenBearer();
  // //
  // Future<String> getTokenBearer() async {
  //   String? token = await getToken();
  //   return "Bearer $token";
  // }
  //
  // Future<String?> getToken() async => (await getCredentials())?.accessToken;
  //
  // Future<Credentials?> getCredentials() async {
  //   Credentials? credentials = global.credentials;
  //   try{
  //     if(credentials != null){
  //       if(credentials.isExpired){
  //         if(!credentials.canRefresh) {
  //           throw Exception("Expired credentials can't be renewed");
  //         }
  //         credentials = await credentials.refresh();
  //       }
  //       return credentials;
  //     }
  //   } catch(e){
  //     print(e);
  //   }
  //   return null;
  // }
}
