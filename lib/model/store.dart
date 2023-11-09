class Store {
  final String id;
  final String idAddress;
  final String imageDescription;
  final String logoUrl;
  final String imageBanner;
  final String facebook;
  final String name;
  final String description;
  final String idUser;
  final String instagram;

  Store({
    required this.id,
    required this.idAddress,
    required this.imageDescription,
    required this.logoUrl,
    required this.imageBanner,
    required this.facebook,
    required this.name,
    required this.description,
    required this.idUser,
    required this.instagram,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'] ?? '',
      idAddress: json['id_address'] ?? '',
      imageDescription: json['image_description'] ?? '',
      logoUrl: json['logo_url'] ?? '',
      imageBanner: json['image_banner'] ?? '',
      facebook: json['facebook'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      idUser: json['id_user'] ?? '',
      instagram: json['instagram'] ?? '',
    );
  }
}
