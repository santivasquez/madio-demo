class ProductPrice {
  String id;
  int price;
  int iva;
  String description;

  ProductPrice({
    required this.id,
    required this.price,
    required this.iva,
    required this.description,
  });

  factory ProductPrice.fromJson(Map<String, dynamic> json) {
    return ProductPrice(
      id: json['id'],
      price: json['price'],
      iva: json['iva'],
      description: json['description'],
    );
  }
}
