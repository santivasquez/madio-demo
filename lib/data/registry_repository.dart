import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:te_regalo/model/address.dart';
import 'package:te_regalo/model/madio_user.dart';

class RegistryRepository {
  String uid = '';
  final baseUrl = 'https://te-regalo-registry.vercel.app/api/v1/registry';
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

  Future<bool> createUser(User user) async {
    if (!await isAuthorized()) {
      throw Exception('Failed to fetch data');
    }

    final url = '$baseUrl/users';

    final response = http.post(
      Uri.parse(url),
      headers: {
        'Content-type': 'application/json',
        'Authorization': token,
      },
      body: json.encode({
        'uid': user.uid,
        'external_id': user.uid,
        'name': user.displayName,
        'last_name': 'apellido',
        'document': "0",
        'id_document_type': "0",
        'phone': 1, //user.phoneNumber,   TODO el back no recibe este formato
        'addresses': [],
        'email': user.email,
        'country': "Colombia",
        'city': "Medellín",
        'photo_url': user.photoURL,
        'display_name': user.displayName,
        'roles': [],
        'gender': "EvnbMmW2QweA6oxMwQa8",
      }),
    );
    response;
    return true;
  }

  Future<MadioUser?> getUser(String uid) async {
    try {
      if (!await isAuthorized()) {
        throw Exception('Failed to fetch data');
      }
      final url = '$baseUrl/users/$uid';

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Authorization': token,
        },
      );

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        print('MadioUser: $json');

        return MadioUser.fromJson(jsonBody);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Address>> getAddresses() async {
    if (!await isAuthorized()) {
      throw Exception('Failed to fetch data');
    }

    final url = '$baseUrl/addresses?id_user=$uid';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-type': 'application/json',
        'Authorization': token,
      },
    );

    if (response.statusCode == 200) {
      final jsonList = json.decode(response.body);
      List<dynamic> adressesList = jsonList;
      print('adresses: $jsonList');

      List<Address> adresses = [];

      if (adressesList != List.empty()) {
        for (final item in adressesList) {
          final objet = Address.fromJson(item);
          adresses.add(objet);
        }
      }

      return adresses;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<Address> saveAddress(Address address) async {
    if (!await isAuthorized()) {
      throw Exception('Failed to fetch data');
    }
    final addressWithUid = address;
    addressWithUid.idUser = uid;
    String jsonAddress = json.encode(addressWithUid.toJson());
    print(jsonAddress);

    final response = await http.post(Uri.parse('$baseUrl/addresses'),
        headers: {
          'Content-type': 'application/json',
          'Authorization': token,
        },
        body: jsonAddress);
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseBody = json.decode(response.body);
      var message = responseBody['message'];
      var data = responseBody['data'];

      return Address.fromJson(data);
    }

    throw Exception('Failed to fetch data: ' + response.body);
  }
}
