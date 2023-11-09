import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:te_regalo/model/delivery_price.dart';

class LogisticsRepository {
  Future<List<DeliveryPrice>> askForDeliveryPrice() async {
    const url =
        'https://madio-express-logistics.vercel.app/api/v1/logistica/cotizar-envio';

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-type': 'application/json'},
      body: '''
    {
    "origen": "MEDELLIN(ANTIOQUIA)",
    "destino": "MEDELLIN(ANTIOQUIA)",
    "valorrecaudo": 39000,
    "productos": [
        {
            "alto": "10",
            "largo": "10",
            "ancho": "10",
            "peso": "1",
            "unidades": 1,
            "nombre": "Nombre producto",
            "valorDeclarado": "39000"
        }
    ],
    "valorMinimo": 0,
    "idasumecosto": 1,
    "contraentrega": 1
}
    ''',
    );
    print(response.body);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print(jsonData);

      final apiResponse = ApiResponse.fromJson(jsonData);

      List<DeliveryPrice> deliveriesPrice = [];

      if (apiResponse != null) {
        for (final item in apiResponse.cotizaciones) {
          deliveriesPrice.add(item);
        }
      }

      return deliveriesPrice;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
