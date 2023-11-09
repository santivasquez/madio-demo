class CelebrationDate {
  final DateTime date;
  final String occasion;

  const CelebrationDate({required this.date, required this.occasion});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['celebration_type_id'] = this.occasion;
    data['date'] = this.date.toIso8601String();
    return data;
  }

  static CelebrationDate fromJson(Map<String, dynamic> json) {
    if (json != null) {
      return CelebrationDate(
        date: DateTime.parse(json['date']),
        occasion: '--cumpleaños--',
      );
    } else {
      return CelebrationDate(date: DateTime(0), occasion: '');
    }
  }
}

class CelebrationType {
  final id;
  final name;

  CelebrationType(this.id, this.name);

  static CelebrationType fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      return CelebrationType(
        json['id'],
        json['text'],
      );
    } else {
      return CelebrationType('', '');
    }
  }
}
