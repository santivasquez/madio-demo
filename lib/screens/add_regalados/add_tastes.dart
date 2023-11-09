import 'package:flutter/material.dart';

import '../../model/taste.dart';

class AddTastes extends StatelessWidget {
  const AddTastes(this.handleAddTastes, this.topicTastes, {super.key});

  final List<TasteTopic> topicTastes;

  final void Function(Taste) handleAddTastes;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () async {
            final result = await showDialog<Taste>(
              context: context,
              builder: (context) {
                final tasteTopicController = TextEditingController();
                final descriptionController = TextEditingController();
                final nameController = TextEditingController();
                return SimpleDialog(
                  title: const Text('Add a new taste'),
                  insetPadding: EdgeInsets.zero,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: nameController,
                        autofocus: true,
                        decoration: const InputDecoration(
                            hintText: 'taste title',
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                    TextFormField(
                      controller: descriptionController,
                      minLines: 2,
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                          hintText: 'Enter message',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ),
                    DropdownButtonFormField<TasteTopic>(
                      decoration: const InputDecoration(
                        labelText: 'Taste topic',
                      ),
                      onChanged: (topic) {
                        if (topic != null) {
                          tasteTopicController.text = topic.id;
                        }
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a Occasion';
                        }
                        return null;
                      },
                      items: topicTastes.map((topic) {
                        return DropdownMenuItem<TasteTopic>(
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
                            Navigator.pop(
                              context,
                              Taste(
                                name: nameController.text,
                                description: descriptionController.text,
                                tasteTopic: tasteTopicController.text,
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
              //state.didChange(state.value!..add(result));
              handleAddTastes(result);
            }
          },
          child: const Text('Add a taste'),
        ),
      ],
    );
  }
}
