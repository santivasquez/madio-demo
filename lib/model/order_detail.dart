import 'package:te_regalo/model/product.dart';
import 'package:te_regalo/model/product_price.dart';

class OrderDetail {
  String id;
  String orderId;
  Product product;
  ProductPrice productPrice;
  int quantity;

  OrderDetail({
    required this.id,
    required this.orderId,
    required this.product,
    required this.productPrice,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      "productId": product.id,
      "cant": quantity,
      "product_price_id": productPrice.id,
    };
  }

  Map<String, dynamic> toJsonOrder() {
    return {
      "product": {"id": product.id},
      "cant": quantity,
      "product_price": {"id": productPrice.id},
    };
  }

  static OrderDetail fromJson(Map<String, dynamic> json) {
    final pModule = json['product_module'];
    return OrderDetail(
      id: json['id'],
      orderId: json['id_order'],
      product: Product.fromJson(pModule['product']),
      productPrice: ProductPrice.fromJson(pModule['product_price']),
      quantity: json['quantity'],
    );
  }
}
