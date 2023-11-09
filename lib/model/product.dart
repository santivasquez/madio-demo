import 'package:te_regalo/model/sub_category.dart';

class Product {
  String id;
  String name;
  String ref;
  String description;
  List<SubCategory> subCategories;
  String ean;
  int weight;
  int height;
  int width;
  String color;
  int size;
  String idBrand;
  List<String> images;

  Product({
    required this.id,
    required this.name,
    required this.ref,
    required this.description,
    required this.subCategories,
    required this.ean,
    required this.weight,
    required this.height,
    required this.width,
    required this.color,
    required this.size,
    required this.idBrand,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      ref: json['ref'],
      description: json['description'],
      subCategories: List<SubCategory>.from(json['subcategories']
          .map((jsonCategory) => SubCategory.fromJson(jsonCategory))),
      ean: json['ean'],
      weight: json['weight'],
      height: json['height'],
      width: json['width'],
      color: json['color'],
      size: json['size'],
      idBrand: json['id_brand'],
      images: List<String>.from(json['images']),
    );
  }
}
