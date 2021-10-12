## Breve descripción
Esta librería es un SDK **(aún en desarrollo)** que tiene como objetivo facilitar el uso de las APIs de [ENZONA](https://www.enzona.net/), de manera tal que el desarrollador solo tenga que concentrarse en la lógica de negocio de su proyecto.

## APIs disponibles

| API | Dispnible |
| ------ | ------ |
| PaymentAPI | :white_check_mark: |
| QRAPI | :ballot_box_with_check: |
| ClaimAPI | :ballot_box_with_check: |
| XMET_AccountAPI | :ballot_box_with_check: |
| XMET_AccountingOperationAPI | :ballot_box_with_check: |

## Primeros pasos
Antes de comenzar a usar este SDK es recomendado que primero revise la documentación oficial proporcionada por el equipo de ENZONA para que conozca el ambiente de pruebas **(bulevar/api sandbox)** y tenga el conocimiento base de los flujos y funcionamiento de las APIs.

 1. [Vea este simple tutorial](https://github.com/MoonMagiCreation/enzona_api#:~:text=http%3A//enzonatuto.intellifoundry.com/%3Ffbclid%3DIwAR2_-5-en2liC64HRyNNkc7DxJ1jpZimnlXciZC6vbgv_Ghe8Va5fBVApsk
)
 2. [Acceda a la documentación y ejemplos oficiales desde el api sandbox](https://apisandbox.enzona.net/store/apis/info?name=PaymentAPI&version=v1.0.0&provider=admin#tab2)
 

## Para usar este SDK
Lo primero es añadir **enzona** como una dependencia más de su proyecto, para esto puede usar el comando:

**Para proyectos puramente en Dart**
```shell
dart pub add enzona
```
**Para proyectos en Flutter**
```shell
flutter pub add enzona
```
Este comando añadirá **enzona** al **pubspec.yaml** de su proyecto.
Finalmente solo tiene que ejecutar:

`dart pub get` **ó** `flutter pub get` según el tipo de proyecto para descargar la dependencia a su pub-cache

## ¿Cómo usar este SDK?
### Muy simple, solo construya una instancia de este SDK de Enzona así:
```dart
final enzona = Enzona(  
  apiUrl: apiUrl, //Url base de las APIs de ENZONA (https://api.enzona.net ó https://apisandbox.enzona.net)
  accessTokenUrl: accessTokenUrl, //Opcionalmente. Url del endpoint de autenticación OAuth2 (https://api.enzona.net/token ó https://apisandbox.enzona.net/token), esta Url en caso de no pasarse se asume automáticamente la Url: '$apiUrl/token'
  consumerKey: consumerKey, //El Consumer Key del Comercio para el cual se desea acceder a las APIs de ENZONA
  consumerSecret: consumerSecret, //El Consumer Secret del Comercio para el cual se desea acceder a las APIs de ENZONA
  scopes: scopes, //El alcance que tendrá el token de autenticacón
  timeout: Duration(seconds: 30), //Opcionalmente el tiempo de espera antes de abortar una petición al API
  httpClient: HttpClient(), //Opcionalmente una instancia de HttpClient para tener control sobre las peticiones http, como la validación de certificados, etc.
);
```
**Y luego la inicialízela así:**
```dart
await enzona.init();
```
**Y listo ya tiene acceso a las APIs de ENZONA...**
> En la mayoría de los casos con una instancia simple como esta bastará:
> ```dart
>final enzona = Enzona(  
>  apiUrl: apiUrl,  
>  consumerKey: consumerKey,  
>  consumerSecret: consumerSecret,  
>  scopes: scopes,  
>);
>```

## ¿Cómo funciona la autenticación?
Las APIs de ENZONA implementan una variante de OAuth2 **(sin renovación de token)** para la autenticación, [*(ver documentación)*](https://apisandbox.enzona.net/store/site/themes/wso2/templates/api/documentation/download.jag?tenant=carbon.super&resourceUrl=/registry/resource/_system/governance/apimgt/applicationdata/provider/admin/PaymentAPI/v1.0.0/documentation/files/C%D1%83mo%20Obtener%20el%20token%20de%20acceso%20en%20las%20%20APIs.docx). Este SDK  implementa autenticación OAuth2 y además se encarga de **renovar el token automáticamente** sin que el desarrollador se tenga que preocupar por eso, en cada petición a las APIs se comprueba la validez del token y si este ha expirado, se procede a re-autenticar, y se continua con la petición original.
De igual forma es posible renovar el token manualmente así como obtener las credenciales de autenticación.
```dart
if(enzona.credentials.isExpired) {  
  final credentials = await enzona.refreshCredentials();  
  print(credentials.accessToken);
}
```

## Detalles a tener en cuenta
En aras de reducir posibles errores en el manejo de nombres de propiedades, filtros y valores: 
 - Se usa la clase **`Params`** donde se definen todos los nombres de propiedades y filtros usados en el SDK.
 - Se usa la clase **`StatusCode`** donde se definen todos los códigos de estado de las transacciones.
 - Se usa la clase **`Order`** para definir el tipo de orden a la hora de filtrar un listado.

Ejemplo:
```dart
final filters = <String, dynamic> {  
  Params.pageIndex: 0,  
  Params.pageSize: 5,  
  Params.order: Order.desc,  
};  
final response = await enzona.paymentAPI.getPayments(filters: filters);  
if(response.isSuccessful && (response.body?.isNotEmpty ?? false)) {  
  final payment = response.body![0];
  if(payment.statusCode == StatusCode.confirmada){  
    print(payment.amount?.total);  
  }
```

## ¿Cómo usar el PaymentAPI?
Desde una instancia del sdk puede acceder a las APIs disponibles, entre estas el API de pagos. Tenga en cuenta que el **scope** *(alcance)* que haya usado para la autenticación es lo que determina a qué APIs podrá acceder con el **token** generado.

### Funciones disponibles PaymentAPI
| Función | Soportada |
| ------ | ------ |
| Listar/filtrar pagos | :white_check_mark: |
| Obtener detalles de un pago | :white_check_mark: |
| Crear un pago | :white_check_mark: |
| Completar un pago | :white_check_mark: |
| Cancelar un pago | :white_check_mark: |
| Listar/filtrar devoluciones | :white_check_mark: |
| Obtener detalles de una devolución | :white_check_mark: |
| Realizar una devolución completa | :white_check_mark: |
| Realizar una devolución parcial | :white_check_mark: |


### Listar/filtrar pagos
```dart
final response = await enzona.paymentAPI.getPayments(
  pageIndex: 0,
  pageSize: 5,
  merchantUUID: merchantUUID,  
  merchantOp: merchantOp,  
  enzonaOp: enzonaOp,  
  status: StatusCode.confirmada,  
  startDate: DateTime.now().subtract(Duration(days: 7)),  
  endDate: DateTime.now(),
  order: Order.desc,
);  
if(response.isSuccessful && (response.body?.isNotEmpty ?? false)) {  
  print('totalCount: ${response.headers[Pagination.totalCountHeader]}');  
  for(var payment in response.body!) {  
    print('id: ${payment.transactionUUID}, statusCode: ${payment.statusCode}');  
  }  
}
```
> **Pagination.totalCountHeader** se refiere a la cantidad total de pagos que existen, este valor se obtiene de los headers del response. Útil para cuando se quiere mostrar un paginado por pasos.

Además de poder especificar los filtros directamente como en el ejemplo anterior, se puede también especificar un Map de filtros con cualquier combinación de filtros:
```dart
final filters = <String, dynamic> {  
  Params.pageIndex: 0,  
  Params.pageSize: 5,  
  Params.merchantUUID: merchantUUID,  
  Params.merchantOp: merchantOp,  
  Params.enzonaOp: enzonaOp,  
  Params.status: StatusCode.confirmada,  
  Params.startDate: DateTime.now().subtract(Duration(days: 7)),  
  Params.endDate: DateTime.now(),  
  Params.order: Order.desc,  
};  
final response = await enzona.paymentAPI.getPayments(  
  filters: filters  
);  
if(response.isSuccessful && (response.body?.isNotEmpty ?? false)) {  
  print('totalCount: ${response.headers[Pagination.totalCountHeader]}');  
  for(var payment in response.body!) {  
    print('id: ${payment.transactionUUID}, statusCode: ${payment.statusCode}');  
  }  
}
```

### Obtener detalles de un pago
```dart
final response = await enzona.paymentAPI.getPayment(transactionUUID: transactionUUID);  
if(response.isSuccessful) {  
   final payment = response.body;
   print('id: ${payment?.transactionUUID}, statusCode: ${payment?.statusCode}');  
}  
```

### Crear un pago
Muy importante haber estudiado [la documentación oficial](https://apisandbox.enzona.net/store/apis/info?name=PaymentAPI&version=v1.0.0&provider=admin#tab2) sugerida en los **Primero pasos** para entender bien cómo funciona el flujo de crear un pago.
Para crear un pago tenemos disponible la clase **`PaymentRequest`** donde se definen valores requeridos y algunos otros opcionales.
```dart
final payment = PaymentRequest(  
  returnUrl: "http://url.to.return.after.payment.confirmation",  
  cancelUrl: "http://url.to.return.after.payment.cancellation",  
  merchantOpId: PaymentRequest.generateRandomMerchantOpId(),  
  currency: "CUP",  
  amount: PaymentAmount(  
    total: 33,  
    details: PaymentAmountDetails(  
      shipping: 1,  
      tax: 0,  
      discount: 2,  
      tip: 4,  
    ),  
  ),  
  items: [  
    PaymentItem(  
      name: "Payment Item 1",  
      description: "Some item description",  
      quantity: 2,  
      price: 15,  
      tax: 0,  
    )  
  ],  
  description: "This is an example payment description",  
);

final response = await enzona.paymentAPI.createPayment(data: payment);  
if(response.isSuccessful) {  
   final createdPayment = response.body;
   print('id: ${createdPayment?.transactionUUID}, statusCode: ${createdPayment?.statusCode}');  
}  
```
Como debe saber una vez creado un pago se debe proceder a confirmarlo, para esto se usa una URL de confirmación que apunta a la plataforma de **ENZONA** desde donde el usuario puede autenticarse y confirmar el pago. Esta URL de confirmación se puede obtener simplemente con:
```dart
  String? confirmationUrl = payment.confirmationUrl;
  launch(confirmationUrl); //El proceso de lanzar la URL en el navegador no se maneja en este SDK
```

### Completar un pago
A partir de un pago confirmado se puede proceder a completarlo.
```dart
final response = await enzona.paymentAPI.completePayment(transactionUUID: payment.transactionUUID!);

if(response.isSuccessful) {  
  final completedPayment = response.body;  
  print('id: ${completedPayment?.transactionUUID}, statusCode: ${completedPayment?.statusCode}');  
} else if(response.error is ErrorResponse &&  
    (response.error as ErrorResponse).code == StatusCode.transaccionNoConfirmada) {  
  final errorResponse = response.error as ErrorResponse;
  print('Mensaje de error: ${errorResponse.message}. El pago debe confirmarse antes de proceder completarse');
}  
```

### Cancelar un pago
A partir de un pago confirmado se puede proceder a cancelarlo.
```dart
final response = await enzona.paymentAPI.cancelPayment(transactionUUID: payment.transactionUUID!);

if(response.isSuccessful) {  
  final cancelledPayment = response.body;  
  print('id: ${cancelledPayment?.transactionUUID}, statusCode: ${cancelledPayment?.statusCode}');  
} else  {  
  print('Hubo un error y no se pudo cancelar el pago.');
}  
```

### Listar/filtrar devoluciones
```dart
final response = await enzona.paymentAPI.getRefunds(
  pageIndex: 0,
  pageSize: 5,
  merchantUUID: merchantUUID,  
  transactionUUID: transactionUUID,  
  commerceRefundId: commerceRefundId,
  status: StatusCode.aceptada,  
  startDate: DateTime.now().subtract(Duration(days: 7)),  
  endDate: DateTime.now(),
  order: Order.desc,
);  
if(response.isSuccessful && (response.body?.isNotEmpty ?? false)) {  
  print('totalCount: ${response.headers[Pagination.totalCountHeader]}');  
  for(var refund in response.body!) {  
    print('id: ${refund.transactionUUID}, statusCode: ${refund.statusCode}');  
  }  
}
```
> **Pagination.totalCountHeader** se refiere a la cantidad total de devoluciones que existen, este valor se obtiene de los headers del response. Útil para cuando se quiere mostrar un paginado por pasos.

Además de poder especificar los filtros directamente como en el ejemplo anterior, se puede también especificar un Map de filtros con cualquier combinación de filtros:
```dart
final filters = <String, dynamic> {  
  pageIndex: 0,
  pageSize: 5,
  merchantUUID: merchantUUID,  
  transactionUUID: transactionUUID,  
  commerceRefundId: commerceRefundId,
  status: StatusCode.aceptada,  
  startDate: DateTime.now().subtract(Duration(days: 7)),  
  endDate: DateTime.now(),
  order: Order.desc,
};  
final response = await enzona.paymentAPI.getRefunds(  
  filters: filters  
);  
if(response.isSuccessful && (response.body?.isNotEmpty ?? false)) {  
  print('totalCount: ${response.headers[Pagination.totalCountHeader]}');  
  for(var refund in response.body!) {  
    print('id: ${refund.transactionUUID}, statusCode: ${refund.statusCode}');  
  }  
}
```

### Obtener detalles de una devolución
```dart
final response = await enzona.paymentAPI.getRefund(transactionUUID: transactionUUID);  
if(response.isSuccessful) {  
   final refund = response.body;
   print('id: ${refund?.transactionUUID}, statusCode: ${refund?.statusCode}');  
}  
```

### Realizar una devolución completa
```dart
final response = await enzona.paymentAPI.refundPayment(transactionUUID: transactionUUID);  
if(response.isSuccessful) {  
   final refund = response.body;
   print('id: ${refund?.transactionUUID}, statusCode: ${refund?.statusCode}');  
}  
```

### Realizar una devolución parcial
```dart
final refund = Refund(  
  amount: PaymentAmount(  
    total: 5,  
  ),  
  description: 'This is a partial refund'  
);  
final response = await enzona.paymentAPI.refundPayment(transactionUUID: transactionUUID, data: refund);

if(response.isSuccessful) {  
   final refund = response.body;
   print('id: ${refund?.transactionUUID}, statusCode: ${refund?.statusCode}');  
}  
```

## Agradecimientos a

 - Janier Treto

## Contribución
Si encuentra algún problema no dude en abrir un ISSUE, siéntase libre de hacer fork, mejorar el SDK y hacer pull request.