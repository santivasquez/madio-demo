import 'package:te_regalo/model/address.dart';

class MadioUser {
  final String uid;
  final String name;
  final String lastName;
  final String document;
  final String documentType;
  final String phone;
  final List<Address> addresses;
  final String email;
  final String country;
  final String city;
  final String photoUrl;
  final String displayName;
  final List<String> roles;

  MadioUser({
    required this.uid,
    required this.name,
    required this.lastName,
    required this.document,
    required this.documentType,
    required this.phone,
    required this.addresses,
    required this.email,
    required this.country,
    required this.city,
    required this.photoUrl,
    required this.displayName,
    required this.roles,
  });

  factory MadioUser.fromJson(Map<String, dynamic> json) {
    return MadioUser(
        uid: json['uid'],
        name: json['name'],
        lastName: json['last_name'],
        document: json['document'],
        documentType: json['id_document_type'],
        phone: json['phone'],
        addresses: json['addresses'],
        email: json['email'],
        country: json['country'],
        city: json['city'],
        photoUrl: json['uphoto_urlid'],
        displayName: json['display_name'],
        roles: json['roles']);
  }
}
