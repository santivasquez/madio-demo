import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:te_regalo/model/supplier.dart';

class MadioStoresRepository {
  String uid = '';
  final baseUrl = 'https://madio-stores.vercel.app/api/v1';
  String token = '';

  Future<bool> isAuthorized() async {
    String? bearer = await FirebaseAuth.instance.currentUser!.getIdToken();

    if (bearer != null) {
      token = "Bearer $bearer";
      uid = await FirebaseAuth.instance.currentUser!.uid;
      return true;
    }
    return false;
  }

  Future<List<Supplier>> getSuppliersByStoreId(String storeId) async {
    if (!await isAuthorized()) {
      throw Exception('Error de autenticación');
    }

    final url = '$baseUrl/suppliers-store/get-by-store-id/$storeId';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-type': 'application/json',
        'Authorization': token,
      },
    );

    if (response.statusCode == 200) {
      final jsonList = json.decode(response.body);
      List<dynamic> suppliersList = jsonList;
      print('suppliers: $jsonList');

      List<Supplier> suppliers = [];

      if (suppliersList != List.empty()) {
        for (final item in suppliersList) {
          final objet = Supplier.fromJson(item['supplier']);
          suppliers.add(objet);
        }
      }

      return suppliers;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
