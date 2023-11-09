class SubCategory {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String idCategory;

  SubCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.idCategory,
  });

  static SubCategory fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['image_url'],
      idCategory: json['id_category'],
    );
  }
}
