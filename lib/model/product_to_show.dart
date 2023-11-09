import 'package:te_regalo/model/product.dart';
import 'package:te_regalo/model/product_price.dart';

class ProductToShow {
  Product product;
  int quantity;
  ProductPrice price;

  ProductToShow({
    required this.product,
    required this.quantity,
    required this.price,
  });

  static ProductToShow fromJson(Map<String, dynamic> json) {
    return ProductToShow(
        product: Product.fromJson(json['product']),
        price: ProductPrice.fromJson(json['product_price']),
        quantity: json['cant']);
  }
}
