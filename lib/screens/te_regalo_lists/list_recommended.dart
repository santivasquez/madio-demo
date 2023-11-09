import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:te_regalo/model/recommendation.dart';
import 'package:te_regalo/screens/te_regalo_lists/recommendation_detail.dart';

class ListRecommended extends StatelessWidget {
  const ListRecommended(this.recommendedList,
      {super.key, required this.header, required this.footer});

  final List<Recommendation> recommendedList;
  final String header;
  final String footer;

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
        : Column(
            children: [
              Text(header),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: recommendedList.length,
                itemBuilder: (BuildContext context, int index) {
                  final recommendation = recommendedList[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 8,
                    shadowColor: const Color.fromARGB(255, 0, 0, 0),
                    color: Colors.transparent,
                    child: ListTile(
                      tileColor: Color.fromARGB(115, 174, 241, 255),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      title: Text(
                        recommendation.title,
                        style: GoogleFonts.getFont('Skranji'),
                      ),
                      subtitle: Text(recommendation.description),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => RecommendationDetailScreen(
                                recommendation: recommendation),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: 10),
              Text(footer),
            ],
          );
  }
}
