class Taste {
  final String key;
  final String name;
  final String description;
  final String tasteTopic;

  const Taste(
      {this.key = '',
      required this.name,
      required this.description,
      required this.tasteTopic});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = name;
    data['description'] = description;
    data['topic_taste_id'] = tasteTopic;
    return data;
  }

  static Taste fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      if (json.isNotEmpty) {
        return Taste(
          key: json['id'],
          name: json['text'],
          description: json['description'],
          tasteTopic: json['topic_taste_id'],
        );
      } else {
        return const Taste(name: '', description: '', tasteTopic: '');
      }
    } else {
      return const Taste(name: '', description: '', tasteTopic: '');
    }
  }
}

class TasteTopic {
  final String id;
  final String name;

  TasteTopic(this.name, this.id);

  static TasteTopic fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      return TasteTopic(json['text'], json['id']);
    } else {
      return TasteTopic('', '');
    }
  }
}
