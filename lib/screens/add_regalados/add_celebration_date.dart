import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:te_regalo/model/celebration_date.dart';

class AddCelebrationDate extends StatelessWidget {
  const AddCelebrationDate(this.handleAddCelebration,
      {super.key, required this.celebrationTypes});

  final void Function(CelebrationDate) handleAddCelebration;
  final List<CelebrationType> celebrationTypes;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () async {
            final result = await showDialog<CelebrationDate>(
              context: context,
              builder: (context) {
                final dateController = TextEditingController();
                final celebrationTypeController = TextEditingController();
                var selectedDate = DateTime.now();
                return SimpleDialog(
                  title: const Text('Add a new celebration date'),
                  contentPadding: const EdgeInsets.all(16),
                  children: [
                    TextFormField(
                      controller: dateController,
                      decoration: const InputDecoration(
                        labelText: 'Date',
                        hintText: 'MM/DD/YYYY',
                      ),
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) {
                          selectedDate = picked;
                          dateController.text = selectedDate.toString();
                        }
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Date is required';
                        }
                        try {
                          value;
                          return null;
                        } on FormatException {
                          return 'Invalid date format';
                        }
                      },
                    ),
                    DropdownButtonFormField<CelebrationType>(
                      decoration: const InputDecoration(
                        labelText: 'Ocasión',
                      ),
                      onChanged: (topic) {
                        if (topic != null) {
                          celebrationTypeController.text = topic.id;
                        }
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Selecciona tipo de Ocación';
                        }
                        return null;
                      },
                      items: celebrationTypes.map((topic) {
                        return DropdownMenuItem<CelebrationType>(
                          value: topic,
                          child: Text(topic.name),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: () {
                            final date = selectedDate;
                            final occasion = celebrationTypeController.text;
                            Navigator.pop(
                              context,
                              CelebrationDate(
                                date: date,
                                occasion: occasion,
                              ),
                            );
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
            if (result != null) {
              //state.didChange(result);
              handleAddCelebration(result);
            }
          },
          child: const Text('Add a celebration date'),
        ),
      ],
    );
  }
}
