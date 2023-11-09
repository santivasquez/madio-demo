class Relationship {
  final String name;
  final String value;

  Relationship(this.name, this.value);

  static Relationship fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      return Relationship(json['text'], json['id']);
    } else {
      return Relationship('', '');
    }
  }
}
