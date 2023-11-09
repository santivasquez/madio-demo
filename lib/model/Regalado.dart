import 'package:te_regalo/model/celebration_date.dart';
import 'package:te_regalo/model/gender.dart';
import 'package:te_regalo/model/taste.dart';

class Regalado {
  final String id;
  final String name;
  final String lastName;
  final String uid;
  final List<Taste>? tastes;
  final List<CelebrationDate>? cdates;
  final int ageMin;
  final int ageMax;
  final String gender;
  final String relationship;

  const Regalado({
    required this.id,
    required this.name,
    required this.lastName,
    required this.uid,
    required this.tastes,
    required this.cdates,
    required this.ageMin,
    required this.ageMax,
    required this.gender,
    required this.relationship,
  });

  factory Regalado.fromJson(Map<String, dynamic> json) {
    return Regalado(
      id: json['id'],
      name: json['name'],
      lastName: json['last_name'],
      uid: json['uid'],
      tastes: List<Taste>.from(json['tastes'].map((x) => Taste.fromJson(x))),
      cdates: List<CelebrationDate>.from(
          json['celebrationDates'].map((x) => CelebrationDate.fromJson(x))),
      ageMin: json['ageMin'] ?? 0,
      ageMax: json['ageMax'] ?? 0,
      gender: Gender.fromJson(json['gender']).value,
      relationship: json['relationship_id'] ?? '',
    );
  }
}
