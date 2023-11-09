import 'package:flutter/material.dart';
import 'package:te_regalo/model/taste.dart';

class ListTastes extends StatelessWidget {
  const ListTastes(this.tatesList, {super.key});

  final List<Taste> tatesList;

  @override
  Widget build(BuildContext context) {
    return tatesList.isEmpty
        ? const Center(
            child: Text('No tates added yet'),
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: tatesList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(title: Text(tatesList[index].name));
            },
          );
  }
}
