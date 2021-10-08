
import 'dart:io';

import 'package:enzona/enzona.dart';

/// Make sure to set all of this environment variables before running tests
///
/// export ENZONA_API_URL=https://apisandbox.enzona.net/payment/v1.0.0
/// export ENZONA_ACCESS_TOKEN_URL=https://apisandbox.enzona.net/token
/// export ENZONA_CONSUMER_KEY=your_consumer_key
/// export ENZONA_CONSUMER_SECRET=your_consumer_secret
/// export ENZONA_SCOPES=am_application_scope,enzona_business_payment,enzona_business_qr
///
final String? apiUrl = Platform.environment['ENZONA_API_URL'];
final String? accessTokenUrl = Platform.environment['ENZONA_ACCESS_TOKEN_URL'];
final String? consumerKey = Platform.environment['ENZONA_CONSUMER_KEY'];
final String? consumerSecret = Platform.environment['ENZONA_CONSUMER_SECRET'];
List<String>? scopes = Platform.environment['ENZONA_SCOPES']?.split(',');

Enzona enzona = Enzona(
  apiUrl: '',
  accessTokenUrl: '',
  consumerKey: '',
  consumerSecret: '',
  scopes: [],
);

Future<void> init() async {

  if(enzona.isInitialized) return;

  if(apiUrl == null) throw Exception("apiUrl can't be null");
  if(accessTokenUrl == null) throw Exception("accessTokenUrl can't be null");
  if(consumerKey == null) throw Exception("consumerKey can't be null");
  if(consumerSecret == null) throw Exception("consumerSecret can't be null");
  if(scopes == null) throw Exception("scopes can't be null");

  enzona = Enzona(
    apiUrl: apiUrl!,
    accessTokenUrl: accessTokenUrl!,
    consumerKey: consumerKey!,
    consumerSecret: consumerSecret!,
    scopes: scopes!,
    timeout: Duration(seconds: 5)
  );
  await enzona.init();
}
