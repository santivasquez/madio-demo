import 'package:flutter/material.dart';
import 'package:te_regalo/model/celebration_date.dart';

class ListDates extends StatelessWidget {
  const ListDates(this.datesList, {super.key});

  final List<CelebrationDate> datesList;

  @override
  Widget build(BuildContext context) {
    return datesList.isEmpty
        ? const Center(
            child: Text('No dates added yet'),
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: datesList.length,
            itemBuilder: (BuildContext context, int index) {
              final occasion = datesList[index].occasion;
              final date = datesList[index].date;
              return ListTile(
                title: Text('$occasion : $date'),
              );
            },
          );
  }
}
