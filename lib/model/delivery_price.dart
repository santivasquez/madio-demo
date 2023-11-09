class DeliveryPrice {
  final String numberError;
  final String dataError;
  final String codTransportadora;
  final String nombreTransportadora;
  final String logoTransportadora;
  final String logoTransportadora2;
  final String origen;
  final String destino;
  final int unidades;
  final int kilos;
  final int pesovolumen;
  final String valoracion;
  final String porcentajeValoracion;
  final String codigoTrayecto;
  final String trayecto;
  final String tipoEnvio;
  final int fletexkilo;
  final int fletexunidad;
  final int fletetotal;
  final String diasentrega;
  final int costoManejo;
  final int valorTotal;
  final int valorOtrosRecaudos;
  final int total;

  DeliveryPrice({
    required this.numberError,
    required this.dataError,
    required this.codTransportadora,
    required this.nombreTransportadora,
    required this.logoTransportadora,
    required this.logoTransportadora2,
    required this.origen,
    required this.destino,
    required this.unidades,
    required this.kilos,
    required this.pesovolumen,
    required this.valoracion,
    required this.porcentajeValoracion,
    required this.codigoTrayecto,
    required this.trayecto,
    required this.tipoEnvio,
    required this.fletexkilo,
    required this.fletexunidad,
    required this.fletetotal,
    required this.diasentrega,
    required this.costoManejo,
    required this.valorTotal,
    required this.valorOtrosRecaudos,
    required this.total,
  });

  factory DeliveryPrice.fromJson(Map<String, dynamic> json) {
    final String error = json['dataerror'];
    if (error.isEmpty) {
      return DeliveryPrice(
        numberError: json['numbererror'],
        dataError: json['dataerror'],
        codTransportadora: json['codTransportadora'],
        nombreTransportadora: json['nombreTransportadora'],
        logoTransportadora: json['logoTransportadora'],
        logoTransportadora2: json['logoTransportadora2'] ?? '',
        origen: json['origen'],
        destino: json['destino'],
        unidades: json['unidades'],
        kilos: json['kilos'],
        pesovolumen: json['pesovolumen'],
        valoracion: json['valoracion'],
        porcentajeValoracion: json['porcentajeValoracion'],
        codigoTrayecto: json['codigoTrayecto'],
        trayecto: json['trayecto'],
        tipoEnvio: json['tipoEnvio'],
        fletexkilo: json['fletexkilo'],
        fletexunidad: json['fletexunidad'],
        fletetotal: json['fletetotal'],
        diasentrega: json['diasentrega'],
        costoManejo: json['costoManejo'],
        valorTotal: json['valorTotal'],
        valorOtrosRecaudos: json['valorOtrosRecaudos'],
        total: json['total'],
      );
    } else {
      return DeliveryPrice(
        numberError: '',
        dataError: '',
        codTransportadora: '',
        nombreTransportadora: '',
        logoTransportadora:
            'https://static.thenounproject.com/png/504708-200.png',
        logoTransportadora2: '',
        origen: '',
        destino: '',
        unidades: 0,
        kilos: 0,
        pesovolumen: 0,
        valoracion: '',
        porcentajeValoracion: '',
        codigoTrayecto: '',
        trayecto: '',
        tipoEnvio: '',
        fletexkilo: 0,
        fletexunidad: 0,
        fletetotal: 0,
        diasentrega: '',
        costoManejo: 0,
        valorTotal: 0,
        valorOtrosRecaudos: 0,
        total: 0,
      );
    }
  }
}

class ApiResponse {
  final String status;
  final String message;
  final List<DeliveryPrice> cotizaciones;

  ApiResponse({
    required this.status,
    required this.message,
    required this.cotizaciones,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> cotizacionesData = json['cotizaciones'];
    final cotizacionesList =
        cotizacionesData.map((e) => DeliveryPrice.fromJson(e)).toList();

    return ApiResponse(
      status: json['status'],
      message: json['message'],
      cotizaciones: cotizacionesList,
    );
  }
}
