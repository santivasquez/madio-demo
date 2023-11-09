class Supplier {
  final String id;
  final String name;
  final String lastName;
  final String idDocumentType;
  final String document;
  final int phone;
  final String idAddress;
  final String email;
  final String idUser;
  final String description;
  final String logoUrl;
  final String instagram;
  final String facebook;
  final String imageBanner;
  final String imageDescription;

  Supplier({
    required this.id,
    required this.name,
    required this.lastName,
    required this.idDocumentType,
    required this.document,
    required this.phone,
    required this.idAddress,
    required this.email,
    required this.idUser,
    required this.description,
    required this.logoUrl,
    required this.instagram,
    required this.facebook,
    required this.imageBanner,
    required this.imageDescription,
  });

  factory Supplier.fromJson(Map<String, dynamic> json) {
    return Supplier(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      lastName: json['last_name'] ?? '',
      idDocumentType: json['id_document_type'] ?? '',
      document: json['document'] ?? '',
      phone: json['phone'] ?? 0,
      idAddress: json['id_Address'] ?? '',
      email: json['email'] ?? '',
      idUser: json['id_user'] ?? '',
      description: json['description'] ?? '',
      logoUrl: json['logo_url'] ?? '',
      instagram: json['instagram'] ?? '',
      facebook: json['facebook'] ?? '',
      imageBanner: json['image_banner'] ?? '',
      imageDescription: json['image_description'] ?? '',
    );
  }

  factory Supplier.empty() {
    return Supplier(
      id: '',
      name: '',
      lastName: '',
      idDocumentType: '',
      document: '',
      phone: 0,
      idAddress: '',
      email: '',
      idUser: '',
      description: '',
      logoUrl: '',
      instagram: '',
      facebook: '',
      imageBanner: '',
      imageDescription: '',
    );
  }
}
