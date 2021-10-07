library enzona;
import 'package:enzona/src/apiservice/payment_api.dart';
import 'package:enzona/src/base_api/custom_oauth2_client.dart';
import 'package:enzona/src/base_api/rest_api.dart';
import 'package:oauth2/oauth2.dart' as oauth2;

export 'package:enzona/src/apiservice/payment_api.dart';

export 'package:enzona/src/entity/error_response.dart';
export 'package:enzona/src/entity/pagination.dart';
export 'package:enzona/src/entity/payment.dart';
export 'package:enzona/src/entity/payment_amount.dart';
export 'package:enzona/src/entity/payment_amount_details.dart';
export 'package:enzona/src/entity/payment_item.dart';
export 'package:enzona/src/entity/payment_link.dart';
export 'package:enzona/src/entity/payment_request.dart';
export 'package:enzona/src/entity/refund.dart';

export 'package:enzona/src/enumerator/status_code.dart';

class Enzona {
  final String apiUrl;
  final String accessTokenUrl;
  final String consumerKey;
  final String consumerSecret;
  final List<String> scopes;
  final Duration? timeout;
  late final CustomOauth2Client httpClient;
  late final PaymentAPI paymentAPI;
  bool _initialized = false;

  Enzona({
    required this.apiUrl,
    required this.accessTokenUrl,
    required this.consumerKey,
    required this.consumerSecret,
    required this.scopes,
    this.timeout,
  });

  bool get isInitialized => _initialized;

  Future<void> init() async {
    if(isInitialized) return;

    /// Oauth2 httpClient does token refresh automatically, but due to the lack
    /// of a proper refresh token implementation from Enzona API the token refresh
    /// should be done as new clientCredentialsGrant.
    /// CustomOauth2Client is a wrapper that does exactly the same as official
    /// Oauth2 Client but in addition it ensures token refresh by doing a
    /// clientCredentialsGrant.

    httpClient = CustomOauth2Client.fromOauth2Client(
      await oauth2.clientCredentialsGrant(
        Uri.parse(accessTokenUrl),
        consumerKey,
        consumerSecret,
        scopes: scopes,
      )
    );

    restAPI.init(
      httpClient: httpClient,
      apiUrl: apiUrl,
      timeout: timeout,
    );

    paymentAPI = PaymentAPI();
    _initialized = true;
  }
}
