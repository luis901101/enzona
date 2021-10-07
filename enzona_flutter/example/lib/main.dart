import 'package:example/src/page/payment_confirmation_embed_page.dart';
import 'package:flutter/material.dart';

/// Make sure to put all of this environment variables in your
/// flutter run command or in your Additional run args in your selected
/// configuration.
///
/// For example:
///
/// flutter run
/// --dart-define=ENZONA_API_URL=https://apisandbox.enzona.net/payment/v1.0.0
/// --dart-define=ENZONA_ACCESS_TOKEN_URL=https://apisandbox.enzona.net/token
/// --dart-define=ENZONA_CONSUMER_KEY=your_consumer_key
/// --dart-define=ENZONA_CONSUMER_SECRET=your_consumer_secret
/// --dart-define=ENZONA_SCOPES=am_application_scope,enzona_business_payment,enzona_business_qr
///
const String apiUrl = String.fromEnvironment('ENZONA_API_URL', defaultValue: 'https://apisandbox.enzona.net/payment/v1.0.0');
const String accessTokenUrl = String.fromEnvironment('ENZONA_ACCESS_TOKEN_URL', defaultValue: 'https://apisandbox.enzona.net/token');
const String consumerKey = String.fromEnvironment('ENZONA_CONSUMER_KEY', defaultValue: 'your_consumer_key');
const String consumerSecret = String.fromEnvironment('ENZONA_CONSUMER_SECRET', defaultValue: 'your_consumer_secret');
final List<String> scopes = const String.fromEnvironment('ENZONA_SCOPES', defaultValue: 'am_application_scope,enzona_business_payment,enzona_business_qr').split(',');

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejemplos de Enzona para Flutter'),
      ),
      body: Scrollbar(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Confirmar pago con Widget embebido'),
              subtitle: const Text('En este ejemplo se muestra cómo utilizar el Widget para confirmación de pagos embebido en un WidgetTree'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentConfirmationEmbedPage()));
              },
            ),
          ],
        )
      ),
    );
  }
}
