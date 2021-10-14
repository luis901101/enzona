## Descripción
Este plugin para Flutter **(aún en desarrollo)** tiene como objetivo complementar el SDK de [enzona](https://pub.dev/packages/enzona).
**Se recomienda antes de usar este plugin que revise la documentación de [enzona](https://pub.dev/packages/enzona).**

## Configuraciones requeridas en Android
...

## Configuraciones requeridas en iOS
...

## Funcionalidades disponibles

 - **Manejo de confirmación de pagos**


## Manejo de confirmación de pagos
La confirmación de un pago se realiza directamente en la plataforma de [ENZONA](https://www.enzona.net/), una vez confirmado o cancelado un pago por parte de un cliente, la plataforma de **ENZONA** redirecciona a la URL `return_url` o `cancel_url` respectivamente indicando de esta manera el fin del flujo de confirmación de pago. 
Para el manejo de la confirmación se ofrecen varias formas:

 - **PaymentConfirmationView**: un Widget para usarlo directamente en un WidgetTree, hace uso de un **WebView** para cargar la URL de la plataforma de ENZONA.
 
 - **PaymentConfirmationScreen**: un Widget para usarlo independiente del WidgetTree, o sea como una pantalla *(route)* independiente. Internamente hace uso de **PaymentConfirmationView**. 
 
 - **PaymentConfirmationExternalLink** un Widget para usarlo independiente del WidgetTree, o sea como una pantalla *(route)* independiente, este abre el navegador del Sistema para cargar la URL de la plataforma de ENZONA.

### ¿Cómo usar PaymentConfirmationView?
**PaymentConfirmationView** se expande horizontal y verticalmente para ocupar todo el espacio disponible, por tal razón es importante tener en cuenta a la hora de ubicarlo dentro de un WidgetTree las restricciones de tamaño *(size constraints)*, es decir si se usa dentro de un **Column** o dentro de un **ListView** será necesario limitar su tamaño verticalmente.
Básicamente son requeridos tres elementos, el objeto de tipo **`Payment`** que se obtiene luego de crear un pago, un **callback** para obtener el pago en caso de ser confirmado **`onPaymentConfirmed`** y otro **callback** para obtener el pago en caso de ser cancelado **`onPaymentCancelled`**. 
> Opcionalmente se puede definir un **`ThemeData`** para personalizar como luce el Widget, por defecto se usa el tema global de la app.
```dart
SizedBox(  
  height: MediaQuery.of(context).size.height * 70 / 100,  
  child: PaymentConfirmationView(  
    payment: payment,  
    themeData: themeData,
    onPaymentConfirmed: (payment) {  
      setState(() {  
        this.payment = payment;  
      });  
    },  
    onPaymentCancelled: (payment) {  
      setState(() {  
        paymentCancelled = true;  
      });  
    },  
  ),  
)
```

### ¿Cómo usar PaymentConfirmationScreen?
**PaymentConfirmationScreen** está ideado para usarse como una pantalla dedicada específicamente para la confirmación de un pago, internamente usa una instancia de **PaymentConfirmationView**. 
La respuesta del pago *(confirmado o cancelado)* se puede obtener de dos formas: 

 - Usando los **callbaks** descritos anteriormente 
 - Esperando el resultado del **Future** que devuelve el **route** una vez que es se termina el flujo de confirmación de pago.

#### Usando los callbacks
```dart
void launchPaymentConfirmationScreen() {  
  Navigator.push(context,  
    MaterialPageRoute(builder: (context) =>  
      PaymentConfirmationScreen(  
        title: 'Confirmar pago',  
        payment: payment!,  
        onPaymentConfirmed: onPaymentChanged,  
        onPaymentCancelled: onPaymentChanged,  
      )));  
} 

void onPaymentChanged(Payment payment) {  
  setState(() {  
    this.payment = payment;  
    if(payment.statusCode != StatusCode.confirmada) {  
      paymentCancelled = true;  
    }  
  });  
}
```

#### Esperando el resultado del Future
```dart
Future<void> launchPaymentConfirmationScreen() async {  
  final result = await Navigator.push(context,  
    MaterialPageRoute(builder: (context) =>  
      PaymentConfirmationScreen(  
        title: 'Confirmar pago',  
        payment: payment!,  
        themeData: ThemeData.dark().copyWith(  
          colorScheme: ThemeData.dark().colorScheme.copyWith(  
            primary: Colors.deepOrange,  
            secondary: Colors.tealAccent  
          )  
        ),  
      )  
    ));  
  if(result is Payment) {  
    setState(() {  
      payment = result;  
      if(payment?.statusCode != StatusCode.confirmada) {  
        paymentCancelled = true;  
      }  
    });  
  }  
}
```
> Opcionalmente  puede:
> - Definir un título 
> - Usar un **`ThemeData`** para personalizar como luce el Widget, por defecto se usa el tema global de la app.


### ¿Cómo usar PaymentConfirmationExternalLink?
**PaymentConfirmationExternalLink** no usa internamente un **PaymentConfirmationView** sino que usa el navegador web del sistema para acceder a la URL de confirmación de la plataforma ENZONA. Cuando se usa **PaymentConfirmationExternalLink** es necesario pasarle una instancia del SDK de **[enzona](https://pub.dev/packages/enzona)**, debido a que internamente comprueba el estado del pago una vez que el usuario sale del navegador del sistema y regresa a la app.
La respuesta del pago *(confirmado o cancelado)* se puede obtener de dos formas: 
 - Usando los **callbaks** descritos anteriormente 
 - Esperando el resultado del **Future** que devuelve el **route** una vez que es se termina el flujo de confirmación de pago.

#### Usando los callbacks
```dart
void launchPaymentConfirmationScreen() {  
  Navigator.push(context,  
    MaterialPageRoute(builder: (context) =>  
      PaymentConfirmationExternalLink(  
        title: 'Confirmar pago en app externa',  
        enzona: enzona,  
        payment: payment!,  
        onPaymentConfirmed: onPaymentChanged,  
        onPaymentCancelled: onPaymentChanged,  
        tryUniversalLinks: true,  
        onError: onError,  
     )));  
}  

void onPaymentChanged(Payment payment) {  
  setState(() {  
    this.payment = payment;  
    if(payment.statusCode != StatusCode.confirmada) {  
      paymentCancelled = true;  
    }  
  });  
}

void onError({Object? error, Exception? exception}) {  
  errorMessage = 'Error desconocido';  
  if(error is ErrorResponse && error.message != null) {  
    errorMessage = '${error.message}';  
  } else  
  if(exception != null) {  
    errorMessage = exception.toString();  
  }  
  setState(() {});  
}
```

#### Esperando el resultado del Future
```dart
Future<void> launchPaymentConfirmationScreen() async {  
  final result = await Navigator.push(context,  
    MaterialPageRoute(builder: (context) =>  
      PaymentConfirmationExternalLink(  
        title: 'Confirmar pago en app externa Variante 1',  
        enzona: enzona,  
        payment: payment!,  
        tryUniversalLinks: true,  
        themeData: ThemeData.light().copyWith(  
          colorScheme: ThemeData.light().colorScheme.copyWith(  
            primary: Colors.orange,  
          )  
        ),  
      )  
    ));  
 if(result is Payment) {  
    setState(() {  
      payment = result;  
      if(payment?.statusCode != StatusCode.confirmada) {  
        paymentCancelled = true;  
      }  
    });  
  } else {  
    // If code reach here an error occurred  
    onError(  
      error: result is ErrorResponse ? result : null,  
      exception: result is Exception ? result : null,  
    );  
  }  
}  
  
void onError({Object? error, Exception? exception}) {  
  errorMessage = 'Error desconocido';  
  if(error is ErrorResponse && error.message != null) {  
    errorMessage = '${error.message}';  
  } else  
  if(exception != null) {  
    errorMessage = exception.toString();  
  }  
  setState(() {});  
}
```
> Opcionalmente  puede:
> - Definir un título 
> - Usar un **`ThemeData`** para personalizar como luce el Widget, por defecto se usa el tema global de la app.
> - Definir un callback **`onError`** para recibir cualquier error que pueda ocurrir en el proceso.
> - Definir `tryUniversalLinks` en `true`, esto sería para que la URL de confirmación se lance al sistema operativo como un Universal Link lo cual significa que si la app oficial de ENZONA reconoce el link de confirmación entonces el usuario usaría la propia app de ENZONA en vez del navegador para confirmar el pago. 


## Contribución  
Si encuentra algún problema no dude en abrir un ISSUE, siéntase libre de hacer fork, mejorar el plugin y hacer pull request.