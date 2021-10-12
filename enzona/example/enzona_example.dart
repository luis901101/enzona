import 'dart:io';

import 'package:enzona/enzona.dart';

/// Make sure to set all of this environment variables before running tests
///
/// export ENZONA_API_URL=https://apisandbox.enzona.net
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

void main() {
  final enzona = Enzona(
    apiUrl: apiUrl!,
    accessTokenUrl: accessTokenUrl!,
    consumerKey: consumerKey!,
    consumerSecret: consumerSecret!,
    scopes: scopes!,
    timeout: Duration(seconds: 30),
    httpClient: HttpClient(),
  );
}
