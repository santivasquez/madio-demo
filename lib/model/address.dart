class Address {
  String id;
  String idUser;
  String title;
  String neighborhood;
  String city;
  String state;
  String country;
  String address;
  String description;
  String mapsUrl;

  Address({
    required this.id,
    required this.idUser,
    required this.title,
    required this.neighborhood,
    required this.city,
    required this.state,
    required this.country,
    required this.address,
    required this.description,
    required this.mapsUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      "id_user": idUser,
      "title": title,
      "neighborhood": neighborhood,
      "city": city,
      "state": state,
      "country": country,
      "address": address,
      "description": description,
      "lat": 0,
      "long": 0,
      "maps_url": mapsUrl,
    };
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      idUser: json['id_user'],
      title: json['title'],
      neighborhood: '',
      city: json['city'],
      state: json['state'],
      country: json['country'],
      address: json['address'],
      description: json['description'],
      mapsUrl: '',
    );
  }
}
