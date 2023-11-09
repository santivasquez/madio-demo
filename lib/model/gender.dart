class Gender {
  final String name;
  final String value;

  Gender(this.name, this.value);

  static Gender fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      return Gender(json['text'], json['id']);
    } else {
      return Gender('', '');
    }
  }
}
