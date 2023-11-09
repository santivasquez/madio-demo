import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ListRecommendedString extends StatelessWidget {
  const ListRecommendedString(this.recommendedList, {super.key});

  final List<String> recommendedList;

  @override
  Widget build(BuildContext context) {
    return recommendedList.isEmpty
        ? Center(
            child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Generando recomendaciones con '),
                  Text(
                    'I.A',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  LoadingAnimationWidget.stretchedDots(
                    color: Colors.black,
                    size: 20,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 8),
                child: LinearProgressIndicator(),
              )
            ],
          ))
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: recommendedList.length,
            itemBuilder: (BuildContext context, int index) {
              final occasion = recommendedList[index];
              return ListTile(
                title: Text(occasion),
              );
            },
          );
  }
}
