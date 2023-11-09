import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:te_regalo/model/category.dart';
import 'package:te_regalo/model/order.dart';
import 'package:http/http.dart' as http;
import 'package:te_regalo/model/order_detail.dart';
import 'package:te_regalo/model/product_to_show.dart';
import 'package:te_regalo/model/sub_category.dart';

class MadioRepository {
  String uid = '';
  final baseUrl = 'https://madio-supply-chain.vercel.app/api/v1/';
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

  Future<List<Category>> getCategories() async {
    if (!await isAuthorized()) {
      throw Exception('Error de autenticación');
    }

    final url =
        'https://madio-supply-chain.vercel.app/api/v1/merchandise/categories';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-type': 'application/json',
        'Authorization': token,
      },
    );

    if (response.statusCode == 200) {
      final jsonList = json.decode(response.body);
      //Map<String, dynamic> jsonData = jsonDecode(response.body);
      List<dynamic> categoriesList = jsonList;
      print('Categories: $jsonList');

      List<Category> categories = [];

      if (categoriesList != List.empty()) {
        for (final item in categoriesList) {
          final objet = Category.fromJson(item);
          categories.add(objet);
        }
      }

      return categories;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<List<SubCategory>> getSubCategoriesByCategoryId(
      String categoryId) async {
    if (!await isAuthorized()) {
      throw Exception('Error de autenticación');
    }

    final url =
        'https://madio-supply-chain.vercel.app/api/v1/merchandise/subcategories?id_category=$categoryId';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-type': 'application/json',
        'Authorization': token,
      },
    );

    if (response.statusCode == 200) {
      final jsonList = json.decode(response.body);
      List<dynamic> subCategoriesList = jsonList;
      print('SubCategory: $jsonList');

      List<SubCategory> subCategories = [];

      if (subCategoriesList != List.empty()) {
        for (final item in subCategoriesList) {
          final objet = SubCategory.fromJson(item);
          subCategories.add(objet);
        }
      }

      return subCategories;
    } else {
      throw Exception('Error de autenticación');
    }
  }

  Future<List<ProductToShow>> getProdcutsToShow() async {
    if (!await isAuthorized()) {
      throw Exception('Failed to fetch data');
    }
    print('token: ' + token);
    const url =
        'https://madio-supply-chain.vercel.app/api/v1/stock/products-module/products-to-show';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-type': 'application/json',
        'Authorization': token,
      },
    ).timeout(
      const Duration(seconds: 15),
      onTimeout: () {
        return http.Response('Error', 408);
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> productList = json.decode(response.body);
      print(productList);

      List<ProductToShow> productsToShow = [];

      if (productList != List.empty()) {
        for (final item in productList) {
          final objet = ProductToShow.fromJson(item);
          productsToShow.add(objet);
        }
      }

      return productsToShow;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<bool> validateProdcutToShow(
      ProductToShow productToShow, int cant) async {
    if (!await isAuthorized()) {
      throw Exception('Failed to fetch data');
    }

    final url =
        'https://madio-supply-chain.vercel.app/api/v1/stock/products-module/products-to-show/validate/${productToShow.product.id}?id_product_price=${productToShow.price.id}&cant=$cant';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-type': 'application/json',
        'Authorization': token,
      },
    ).timeout(
      const Duration(seconds: 15),
      onTimeout: () {
        return http.Response('Error', 408);
      },
    );
    print(response);

    final validation = json.decode(response.body);
    print(validation);
    if (response.statusCode == 200) {
      String status = validation['message'];

      bool hasStock = false;
      if (status == 'Product available') {
        hasStock = true;
      } else {
        hasStock = false;
      }

      return hasStock;
    } else if (response.statusCode == 409) {
      String status = validation['error'];

      if (status == 'Not enough products') {
        return false;
      } else {
        return false;
      }
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<bool> sendOrder(Order order, List<OrderDetail> orderDetails) async {
    if (!await isAuthorized()) {
      throw Exception('No autorizado');
    }

    final orderWithUid = order;
    orderWithUid.userId = uid;

    String jsonOrder = json.encode(orderWithUid.toJson());
    print(jsonOrder);

    final response = await http.post(
        Uri.parse('https://madio-sales.vercel.app/api/v1/sales/orders'),
        headers: {
          'Content-type': 'application/json',
          'Authorization': token,
        },
        body: jsonOrder);
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      throw Exception('No se pudo crear el Pedido: ${response.body}');
    }
  }

  Future<List<Order>> getOrders() async {
    if (!await isAuthorized()) {
      throw Exception('Error de autenticación');
    }

    final url =
        'https://madio-sales.vercel.app/api/v1/sales/orders/?id_user=$uid';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-type': 'application/json',
        'Authorization': token,
      },
    );

    if (response.statusCode == 200) {
      final jsonList = json.decode(response.body);
      print(jsonList);

      List<Order> orders = [];

      if (jsonList != List.empty()) {
        for (final item in jsonList) {
          final objet = Order.fromJson(item);
          orders.add(objet);
        }
      }

      return orders;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
