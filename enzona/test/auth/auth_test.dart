import 'package:test/test.dart';

import '../base_tests.dart';

void main() async {

  await init();

  group('Enzona API authentication', () {

    test('OAuth2 authentication', () async {
      expect(enzona.credentials.accessToken, isNotEmpty);
    });

    test('OAuth2 refresh token', () async {
      final credentials = await enzona.refreshCredentials();
      expect(credentials, isNotNull);
    });
  });
}
