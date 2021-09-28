
class ErrorCode {

  ///Codigo de estados generales y denominaciones
  static const aceptada = 1111; //Transaccion Aceptada
  static const fallida = 1112; //Transaccion Fallida
  static const pendiente = 1113; //Transaccion Pendiente
  static const reversada = 1114; //Transaccion Reversada
  static const devuelta = 1115; //Transaccion Devuelta
  static const confirmada = 1116; //Transaccion Confirmada
  static const cancelada = 1117; //Transaccion Cancelada
  static const activada = 1118; //Transaccion Activada
  static const desactivada = 1119; //Transaccion Desactivada

  ///Codigo de estados de las transacciones y sus denominaciones
  static const transferencia = 1000; //Transferencia
  static const regalo = 1100; //Regalo
  static const balance = 1200; //Balance
  static const activacionDeTarjeta = 1300; // Activacion de tarjetas
  static const ultimasOperaciones = 1800; // Últimas operaciones
  static const transferenciaConCambioMoneda = 1001; // Transferencia con cambio de moneda
  static const transferenciaEntreBancos = 1002; // Transferencia entre bancos
  static const transferenciaEntreBancosCambioMoneda = 1003; // Transferencia entre bancos con cambio de moneda
  static const regaloCambioMoneda = 1101; //Regalo con cambio de moneda
  static const regaloEntreBancos = 1102; //Regalo entre bancos
  static const regaloEntreBancosCambioMoneda = 1103; //Regalo entre bancos con Cambio de moneda
  static const pagoDeServicio = 1400; //Pago de servicio
  static const pagoDeServicioCambioMoneda = 1401; //Pago de servicio con cambio de moneda
  static const pagoAComercio = 1500; //Pago a comercio
  static const pagoAComercioCodigoBarra = 1501; //Pago a comercio por codigo de barra
  static const pagoACentaCambioMoneda = 1600; //Pago a una cuenta con cambio de moneda
  static const pagoACuenta = 1601; //Pago a una cuenta

  static const pagoACuentaEntreBancos = 1602; //Pago a una cuenta entre bancos
  static const pagoACuentaBancariaCambioMoneda = 1603; //Pago a una cuenta bancaria con cambio de moneda
  static const donacion = 1700; //Donacion
  static const activacionDeTarjetaCambioMoneda = 1302; //Activacion de tarjeta con cambio de moneda
  static const donacionCambioMoneda = 1701; //Donacion con cambio de moneda
  static const devolucion = 2000; //Devolucion
  static const devolucionTotalCambioMoneda = 2001; //Devolucion total con cambio de moneda
  static const pagoAComercioCambioMoneda = 1502; //Pago del comercio con cambio de moneda
  static const pagoDeFacturaElectrica = 1900; //Pago de servicio de electricidad
  static const devolucionParcial = 2002; //Devolucion parcial
  static const devolucionParcialCambioMoneda = 2003; //Devolucion parcial con cambio de moneda
  static const pagoAComercioCodigoBarraCambioMoneda = 1503; //Codigo de barra del comercio con cambio de moneda
  static const pagoAComercioQR = 1504; //Codigo QR del comercio
  static const pagoAComercioQRCambioMoneda = 1505; //Codigo QR del comercio con cambio de moneda

  static const 	fechaExpiracionTarjetaIncorrecta = 5000; //Fecha de expiracion de la tarjeta incorrecta
  static const 	errorFuncionamientoSistema = 5001; //En estos momentos no se puede realizar su transaccion, por favor intente más tarde
  static const 	noConexionREDSA = 5002; //En estos momentos no se puede realizar su transaccion, por favor intente más tarde
  static const 	respuestaDeBancoIncorrecta = 5003; //En estos momentos no se puede realizar su transaccion, por favor intente más tarde
  static const 	necesitaActualizacionAPK = 5004; //Actualice a la nueva version para utilizar esta funcionalidad
  static const 	usuarioNoTieneAccesoRecursoSolicitado = 4001; //Acceso denegado
  static const 	destinoNoTieneTarjetaActiva = 4002; //El destino no tiene una tarjeta activa
  static const 	tarjetaInexistente = 4003; //Tarjeta inexistente
  static const 	transaccionNoRealizada = 4004; //En estos momentos no se puede realizar su transaccion, por favor intente más tarde
  static const 	tarjetaRegaloInexistente = 4005; //En estos momentos no se puede realizar su transaccion, por favor intente más tarde. Tarjeta de regalo inexistente
  static const 	transaccionNoCompletada = 4006; //En estos momentos no se puede realizar su transaccion, por favor intente más tarde
  static const 	transaccionNoRealizadaCorrectamente = 4007; //En estos momentos no se puede realizar su transaccion, por favor intente más tarde
  static const 	usuarioInexistente = 4008; //Su identidad no es reconocida por el sistema

  static const contrasenaPagoIncorrecta = 4009; //Contraseña de pago incorrecta
  static const usuarioRealizoTransaccionNoPropietarioTarjeta = 4010; //Usted no es propietario de la tarjeta utilizada
  static const cuentaRecipienteNoExiste = 4011; //En estos momentos no se puede realizar su transacción, por favor intente más tarde
  static const tarjetaOVendorIdentityCodeVacios = 4012; //En estos momentos no se puede realizar su transacción, por favor intente más tarde
  static const estadoFuentePagoIncorrecto = 4013; //Su tarjeta no está activa
  static const codigoIdentificativoPagoNoExiste = 4014; //El código identificativo del pago no existe
  static const tarjetaNoPerteneceAlUsuario = 4015; //La tarjeta no pertenece al usuario
  static const monedaInexistente = 4016; //La Moneda no está configurada en el sistema
  static const tarjetaYaExiste = 4017; //La tarjeta ya existe
  static const numeroTarjetaNoPerteneceNingunBanco = 4018; //El número de tarjeta no está habilitado actualmente en el sistema
  static const noSePudoGenerarMicrocredito = 4019; //No se pudo generar el microcrédito, por favor intente más tarde
  static const tarjetaNoPerteneceAlUsuario2 = 4020; //La tarjeta no pertenece al usuario
  static const usuarioAlQueVaAPagarTieneLaMismaTarjetaDelQuePaga = 4021; //El usuario al que va a pagar tiene su misma fuente de pago configurada como primaria
  static const uuidDeDonacionVacio = 4022; //Error en la entrada de datos

  static const montoVacioOCero = 4023; //Monto no permitido
  static const noExistenTransaccionesQueMostrar = 4024; //No existen transacciones que mostrar
  static const donacionInexistente = 4025; //En estos momentos no se puede realizar su transacción, por favor intente más tarde. Donación inexistente
  static const microcreditoEnCero = 4026; //Los códigos de activación han sido utilizados
  static const usuarioNoPuedeAgregarseComoContactoASiMismo = 4027; //Usted no se puede agregar como contacto
  static const usuarioYaPerteneceAListaContactos = 4028; //El usuario ya pertenece a su lista de contactos
  static const uuidDeRelacionDeContactoVacio = 4029; //En estos momentos no se puede realizar su operación, por favor intente más tarde
  static const fundingSourceIguales = 4030; //Operación no permitida
  static const passwordAnteriorNoCoincide = 4031; //Contraseña incorrecta, la credencial anterior no coincide con la existente
  static const usuarioNoSePuedePonerComoContrasena = 4032; //No puede usar el usuario como contraseña
  static const usuarioPerdioTokenOAuth = 4033; //Fallo de autenticación. Inténtelo más tarde
  static const excedidoNumeroIntentosParaAgregarTarjeta = 4034; //La tarjeta ha sido bloqueada
  static const problemasAdicionandoFundingSource = 4035; //En estos momentos no se puede realizar su transacción, por favor intente más tarde

  static const problemasAlAdicionarTarjeta = 4036; //En estos momentos no se puede realizar su transacción, por favor intente más tarde
  static const passwordAlMenos6Caracteres = 4037; //Contraseña incorrecta, debe tener al menos 6 caracteres
  static const noSeEncuentraFundingSource = 4040; //Fuente de pago inexistente
  static const noCoincideAccountIdDeUsuarioConFundingSource = 4041; //El usuario no es propietario de la fuente de pago
  static const noExisteServicioConCodigoDado = 4042; //Servicio no disponible
  static const noExisteCuentaAsociadaAConfiguracionDelServicio = 4043; //Recurso no disponible
  static const usuarioNoPropietarioDeConfiguracionDelServicio = 4044; //Recurso no disponible
  static const noSeEncuentraConfiguracionDelServicio = 4045; //Configuración de servicio inexistente
  static const parametrosDeEntradaCaciosOIncorrectos = 4046; //Parámetros de entrada vacíos o incorrectos
  static const idClienteNoDisponible = 4047; //No se encontró el ID cliente
  static const numeroTelefonoYaEstaRegistrado = 4050; //El número de teléfono ya está registrado
  static const direccionDeCorreoExiste = 4051; //La dirección de correo existe
  static const noPuedePonerCorreoNuloSinTenerTelefonoConfigurado = 4052; //No puede poner la dirección de correo vacía sin tener un teléfono configurado
  static const noPuedePonerTelefonoNuloSinTenerCorreoConfigurado = 4053; //No puede poner el teléfono vacío sin tener una dirección correo configurada

  static const usernameVacio = 4054; //En estos momentos no se puede realizar su transacción, por favor intente más tarde
  static const usernameNoCoincideConElDeLaPeticion = 4055; //En estos momentos no se puede realizar su transacción, por favor intente más tarde
  static const direccionCorreoNoTieneDormatoCorrecto = 4056; //La dirección de correo no tiene el formato correcto
  static const numeroTelefonoNoEstaEnFormatoCorrecto = 4057; //El número de teléfono no está en el formato correcto
  static const comercioInexistente = 4058; //Comercio inexistente
  static const falloActualizacionFundingSource = 4059; //En estos momentos no se puede realizar su operación, por favor intente más tarde
  static const falloActualizacionTransaccion = 4060; //En estos momentos no se puede realizar su operación, por favor intente más tarde
  static const falloObteniendoPreguntasDeComprobacion = 4061; //En estos momentos no se puede realizar su operación, por favor intente más tarde
  static const respuestaIncorrectaReseteandoContrasenaPago = 4062; //Las respuestas están incorrectas, por favor intente más tarde
  static const falloReseteandoContrasenaPago = 4063; //En estos momentos no se puede realizar su operación, por favor intente más tarde
  static const transaccionInexistente = 4064; //Recurso no disponible
  static const transaccionNoConfirmada = 4065; //El pago a devolver no está confirmado
  static const pagoInexistente = 4066; //No existe pago asociado a la transacción
  static const pagoDevueltoEnSuTotalidad = 4067; //Pago devuelto en su totalidad pago

  static const excedidoCantidadMaximaADevolverDelPago = 4068; //Se ha excedido la cantidad máxima a devolver del pago
  static const montoADevolverNoPuedeSerMayorAlTotalDelPago = 4069; //El monto a devolver no puede ser mayor al total del pago
  static const montoADevolverNoPuedeSerCero = 4070; //El monto a devolver no puede ser de $0.00
  static const transaccionNoEsDelTipoDevolucion = 4071; //La transacción no es del tipo devolución
  static const transaccionNoEsDelTipoPagoAComercio = 4072; //La transacción no es del tipo Pago a Comercio
  static const noExisteCheckoutParaEsteUUID = 4073; //Recurso no disponible
  static const tarjetaNoOperativaParaPago = 4074; //Tarjeta no operativa para el pago
  static const deMomentoSoloSePermitenPagosConTarjetasCUP = 4075; //Por el momento solo se permiten realizar pagos con tarjetas en CUP. Disculpe la molestia
  static const bancoInexistente = 4076; //Banco inexistente
  static const codigoQRInexistente = 4077; //Código QR inexistente
  static const codigoQRYaFueUtilizado = 4078; //El código QR ya fue utilizado por favor genere otro
  static const deMomentoSoloSePermitenCuentasCUP = 4079; //Por el momento solo se permiten cuentas en CUP. Disculpe la molestia
  static const numeroCuentaIncorrecto = 4080; //Número de cuenta incorrecto. Por favor rectifíquela

  static const formatoIncorrectoDeDevolucion = 4081; //Formato incorrecto de la devolución. Por favor rectifíquelo
  static const formatoIncorrectoEnEstructuraDePago = 4082; //Formato incorrecto en la estructura del pago. Por favor rectifíquelo
  static const formatoIncorrectoEnEstructuraDePagoSumaTotalDelImpuestoEnProductosNoCoincideConDetallesDelMonto = 4083; //Formato incorrecto en la estructura del pago. La suma total del impuesto en los productos no coincide con los detalles del monto. Por favor rectifíquelo
  static const formatoIncorrectoEnEstructuraDePagoSumaTotalDeDetallesDelMontoNoCoincideConTotal = 4084; //Formato incorrecto en la estructura del pago. La suma total de los detalles del monto no coincide con el total. Por favor rectifíquelo
  static const errorEnEstructuraDeDatos = 4092; //Error en la estructura de Datos
}