import 'dart:convert';

import 'package:te_regalo/model/Regalado.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:te_regalo/model/budget.dart';
import 'package:te_regalo/model/celebration_date.dart';
import 'package:te_regalo/model/gender.dart';
import 'package:te_regalo/model/relationship.dart';
import 'package:te_regalo/model/taste.dart';

class RegaladosRepository {
  final apiKey = 'xHrNxVwCSKTVQu60xV0ocifEuk52';
  final baseUrl = 'https://te-regalo-regalados.vercel.app/api/v1/';
  final baseUrl2 = 'http://192.168.1.4:3000/api/v1/';

  Future<List<Regalado>> getRegalados() async {
    final url =
        'https://te-regalo-gift-recipients.vercel.app/api/v1/gift-recipients?uid=$apiKey&orderBy=celebrationDates&order=desc';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonList = json.decode(response.body);
      print('Regalados: $jsonList');

      List<Regalado> regalados = [];

      if (jsonList != null) {
        for (final item in jsonList) {
          final objet = Regalado.fromJson(item);
          regalados.add(objet);
        }
      }

      return regalados;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<List<TasteTopic>> getTopicTastes(bool useCache) async {
    List<TasteTopic> topicTastes = [];
    if (useCache) {
      String jsonString =
          await rootBundle.loadString('assets/data/topic_tastes.json');
      final jsonList = json.decode(jsonString);
      if (jsonList != null) {
        for (final item in jsonList) {
          final objet = TasteTopic.fromJson(item);
          topicTastes.add(objet);
        }
      }
    } else {
      const url =
          'https://te-regalo-gift-recipients.vercel.app/api/v1/topic-tastes';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonList = json.decode(response.body);
        print('Tastes: $jsonList');

        if (jsonList != null) {
          for (final item in jsonList) {
            final objet = TasteTopic.fromJson(item);
            topicTastes.add(objet);
          }
        }
      } else {
        throw Exception('Failed to fetch data');
      }
    }
    return topicTastes;
  }

  Future<List<CelebrationType>> getCelebrationTypes(bool useCache) async {
    List<CelebrationType> celebrationTypes = [];
    if (useCache) {
      String jsonString =
          await rootBundle.loadString('assets/data/topic_tastes.json');
      final jsonList = json.decode(jsonString);
      if (jsonList != null) {
        for (final item in jsonList) {
          final objet = CelebrationType.fromJson(item);
          celebrationTypes.add(objet);
        }
      }
    } else {
      const url =
          'https://te-regalo-gift-recipients.vercel.app/api/v1/celebration/types';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonList = json.decode(response.body);
        print('Celebration_Types: $jsonList');

        if (jsonList != null) {
          for (final item in jsonList) {
            final objet = CelebrationType.fromJson(item);
            celebrationTypes.add(objet);
          }
        }
      } else {
        throw Exception('Failed to fetch data');
      }
    }
    return celebrationTypes;
  }

  Future<List<Gender>> getGenders(bool useCache) async {
    List<Gender> genders = [];
    if (useCache) {
      String jsonString =
          await rootBundle.loadString('assets/data/genders.json');
      final jsonList = json.decode(jsonString);
      if (jsonList != null) {
        for (final item in jsonList) {
          final objet = Gender.fromJson(item);
          genders.add(objet);
        }
      }
    } else {
      const url =
          'https://te-regalo-registry.vercel.app/api/v1/registry/genders';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonList = json.decode(response.body);
        print(jsonList);

        if (jsonList != null) {
          for (final item in jsonList) {
            final objet = Gender.fromJson(item);
            genders.add(objet);
          }
        }
      } else {
        throw Exception('Failed to fetch data');
      }
    }
    return genders;
  }

  Future<List<Relationship>> getRelationships(bool useCache) async {
    List<Relationship> relationships = [];
    if (useCache) {
      String jsonString =
          await rootBundle.loadString('assets/data/relationships.json');
      final jsonList = json.decode(jsonString);
      if (jsonList != null) {
        for (final item in jsonList) {
          final objet = Relationship.fromJson(item);
          relationships.add(objet);
        }
      }
    } else {
      const url =
          'https://te-regalo-gift-recipients.vercel.app/api/v1/relationships';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonList = json.decode(response.body);
        print(jsonList);

        if (jsonList != null) {
          for (final item in jsonList) {
            final objet = Relationship.fromJson(item);
            relationships.add(objet);
          }
        }
      } else {
        throw Exception('Failed to fetch data');
      }
    }
    return relationships;
  }

  Future<List<String>> getAIRecommendationsString(
      Regalado regalado, Budget budget) async {
    final jsonString = json.encode({
      'budget': budget.toJson(),
    });
    print(jsonString);
    final response = await http
        .post(
      Uri.parse(
          'https://te-regalo-f9173.web.app/api/v1/suggestions/ai/gifted-person/${regalado.id}'),
      headers: {'Content-type': 'application/json'},
      body: jsonString,
    )
        .timeout(
      const Duration(seconds: 20),
      onTimeout: () {
        return http.Response('Error', 408);
      },
    );
    print('response: ${response.body}');
    if (response.statusCode == 200) {
      final jsonList = json.decode(response.body);
      print(jsonList);
      List<String> recommendations = [];
      recommendations.add(jsonList['ai_suggestion']);
      return recommendations;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
