import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:te_regalo/data/regalados_repository.dart';
import 'package:te_regalo/screens/add_regalados/add_celebration_date.dart';
import 'package:te_regalo/screens/add_regalados/list_dates.dart';

import '../../model/Regalado.dart';
import '../../model/celebration_date.dart';
import '../../model/gender.dart';
import '../../model/relationship.dart';
import '../../model/taste.dart';
import 'add_tastes.dart';
import 'list_tastes.dart';

class RegaladoForm extends StatefulWidget {
  const RegaladoForm({Key? key}) : super(key: key);

  @override
  _RegaladoFormState createState() => _RegaladoFormState();
}

class _RegaladoFormState extends State<RegaladoForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _lastName = '';
  final String _uid = '';
  final List<Taste> _tastes = [];
  List<TasteTopic> _topicTastes = [];
  List<CelebrationType> _celebrationTypes = [];
  List<Gender> _genders = [];
  List<Relationship> _relationships = [];
  final List<CelebrationDate> _cdates = [];
  int _ageMin = 0;
  int _ageMax = 0;
  Gender? _gender;
  Relationship? _relationship;

  final RegaladosRepository repository = RegaladosRepository();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final topicTastesResponse = await repository.getTopicTastes(false);
      final relationShipResponse = await repository.getRelationships(false);
      final gendersResponse = await repository.getGenders(false);
      final celebrationTypeResponse =
          await repository.getCelebrationTypes(false);

      setState(() {
        _topicTastes = topicTastesResponse;
        _genders = gendersResponse;
        _relationships = relationShipResponse;
        _celebrationTypes = celebrationTypeResponse;
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  void handleAddTastes(Taste taste) {
    setState(() {
      _tastes.add(taste);
    });
  }

  void handleAddCelebration(CelebrationDate celebration) {
    setState(() {
      _cdates.add(celebration);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Regalado'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 129, 147, 196),
              Color.fromARGB(255, 101, 17, 226)
            ], begin: Alignment.bottomLeft, end: Alignment.topLeft),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 63, 90, 163),
              Color.fromARGB(255, 244, 242, 247),
              Color.fromARGB(255, 61, 83, 126),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
          child: Column(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Name',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _name = value!;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Last Name',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a last name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _lastName = value!;
                          },
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Tastes:',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        AddTastes(handleAddTastes, _topicTastes),
                        ListTastes(_tastes),
                        const SizedBox(height: 16),
                        Text(
                          'Celebration Dates:',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        AddCelebrationDate(
                          handleAddCelebration,
                          celebrationTypes: _celebrationTypes,
                        ),
                        ListDates(_cdates),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Age Min',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a minimum age';
                            }
                            if (int.tryParse(value) == null) {
                              return 'Please enter a valid number';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _ageMin = int.parse(value!);
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Age Max',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a maximum age';
                            }
                            if (int.tryParse(value) == null) {
                              return 'Please enter a valid number';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _ageMax = int.parse(value!);
                          },
                        ),
                        DropdownButtonFormField<Gender>(
                          decoration: const InputDecoration(
                            labelText: 'Género',
                          ),
                          value: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value!;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Seleccione un género';
                            }
                            return null;
                          },
                          items: _genders.map((gender) {
                            return DropdownMenuItem<Gender>(
                              value: gender,
                              child: Text(gender.name),
                            );
                          }).toList(),
                        ),
                        DropdownButtonFormField<Relationship>(
                          decoration: const InputDecoration(
                            labelText: 'Relación',
                          ),
                          value: _relationship,
                          onChanged: (value) {
                            setState(() {
                              _relationship = value!;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Qué relación tienen';
                            }
                            return null;
                          },
                          items: _relationships.map((relationship) {
                            return DropdownMenuItem<Relationship>(
                              value: relationship,
                              child: Text(relationship.name),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              final regalado = Regalado(
                                id: '',
                                name: _name,
                                lastName: _lastName,
                                uid: _uid,
                                tastes: _tastes,
                                cdates: _cdates,
                                ageMin: _ageMin,
                                ageMax: _ageMax,
                                gender: _gender?.value ?? '',
                                relationship: _relationship?.value ?? '',
                              );
                              // TODO: Save the regalado object to a database or other storage.
                              saveTastes(_tastes, regalado, context);
                            }
                          },
                          child: const Text('Guardar'),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void saveTastes(
    List<Taste> tastes, Regalado regalado, BuildContext context) async {
  final url =
      Uri.https('te-regalo-gift-recipients.vercel.app', '/api/v1/tastes');

  print('url ... : ' + url.toString());

  List<String> tastesIds = [];
  int cont = 0;
  tastes.forEach((taste) async {
    final jsonString = json.encode({
      'text': taste.name,
      'description': taste.description,
      'topic_taste_id': taste.tasteTopic,
      'value': taste.description
    });
    print('jsoinToSend ... : ' + jsonString);

    final response = await http.post(url,
        headers: {'Content-type': 'application/json'}, body: jsonString);
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseBody = jsonDecode(response.body);
      var message = responseBody['message'];
      var data = responseBody['data'];

      // Process the received message and data as per your requirement
      print('Message: $message');
      print('Data: $data');
      tastesIds.add(data['id']);
      print("cont: $cont  , lenght: " +
          tastes.length.toString() +
          ' taste_id' +
          data['id']);
      cont++;
      if (cont == tastes.length) {
        saveRegalado(regalado, tastesIds, context);
      }
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  });
}

void saveRegalado(
    Regalado regalado, List<String> tastesIds, BuildContext context) async {
  print("token .4.. : " + regalado.toString());
  inspect(regalado);
  final url = Uri.https(
      'te-regalo-gift-recipients.vercel.app', '/api/v1/gift-recipients');

  print('url ... : ' + url.toString());

  final jsonString = json.encode({
    'id': regalado.id,
    'name': regalado.name,
    'last_name': regalado.lastName,
    'uid': 'xHrNxVwCSKTVQu60xV0ocifEuk52',
    'id_relationship': regalado.relationship,
    'tastes': tastesIds,
    'celebrationDates': regalado.cdates!.map((date) => date.toJson()).toList(),
    'age_min': regalado.ageMin,
    'age_max': regalado.ageMax,
    'id_gender': regalado.gender,
    'id_address': '0',
    'email': '0',
    "country": "0",
    "city": "0",
    "phone": 0,
  });
  print('jsoinToSend ... : ' + jsonString);

  final response = await http.post(url,
      headers: {'Content-type': 'application/json'}, body: jsonString);
  print(response.body);
  print(response.statusCode);
  Navigator.pop(context, true);
}
