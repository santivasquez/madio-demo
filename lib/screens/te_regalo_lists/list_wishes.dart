import 'package:flutter/material.dart';

class ListWishes extends StatelessWidget {
  const ListWishes(this.wishesList, {super.key});

  final List<String> wishesList;

  @override
  Widget build(BuildContext context) {
    return wishesList.isEmpty
        ? const Center(
            child: Text('No Wishes added yet'),
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: wishesList.length,
            itemBuilder: (BuildContext context, int index) {
              final occasion = wishesList[index];
              final date = wishesList[index];
              return ListTile(
                title: Text('$occasion : $date'),
              );
            },
          );
  }
}
