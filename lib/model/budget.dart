class Budget {
  final double initialBudget;
  final double finalBudget;

  const Budget({required this.initialBudget, required this.finalBudget});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['initial'] = initialBudget;
    data['final'] = finalBudget;
    return data;
  }
}
