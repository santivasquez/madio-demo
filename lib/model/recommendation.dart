class Recommendation {
  int number;
  String title;
  String description;

  Recommendation(this.number, this.title, this.description);

  factory Recommendation.fromString(String input) {
    final parts = input.split(". ");
    if (parts.length == 2) {
      final number = int.tryParse(parts[0].trim());
      if (number != null) {
        final titleAndDescription = parts[1].split(":");
        if (titleAndDescription.length == 2) {
          final title = titleAndDescription[0].trim();
          final description = titleAndDescription[1].trim();
          return Recommendation(number, title, description);
        }
      }
    }
    throw FormatException("Invalid input format");
  }

  @override
  String toString() {
    return '$number. $title: $description';
  }
}
