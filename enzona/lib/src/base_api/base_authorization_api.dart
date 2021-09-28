

abstract class BaseAuthorizationAPI
{

  // Future<String> getAuthorization() async => getTokenBearer();
  Future<String> getAuthorization() async => '';
  //
  // Future<String> getTokenBearer() async {
  //   String? token = await getToken();
  //   return "Bearer $token";
  // }

  // Future<String?> getToken() async => (await getCredentials())?.accessToken;

  // Future<Credentials?> getCredentials() async {
  //   Credentials? credentials = App.user.credentials;
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
