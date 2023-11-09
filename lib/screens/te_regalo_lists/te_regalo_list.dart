import 'package:flutter/material.dart';
import 'package:te_regalo/data/madio_repository.dart';
import 'package:te_regalo/data/regalados_repository.dart';
import 'package:te_regalo/model/Regalado.dart';
import 'package:te_regalo/model/budget.dart';
import 'package:te_regalo/model/product_to_show.dart';
import 'package:te_regalo/model/recommendation.dart';
import 'package:te_regalo/screens/shop_screen/list_products_to_show.dart';
import 'package:te_regalo/screens/te_regalo_lists/list_recommended.dart';
import 'package:te_regalo/screens/te_regalo_lists/list_wishes.dart';
import 'package:te_regalo/widgets/expanded_list.dart';

class TeRegaloList extends StatefulWidget {
  const TeRegaloList(this.regalado, {Key? key}) : super(key: key);

  final Regalado regalado;

  @override
  _TeRegaloList createState() => _TeRegaloList();
}

class _TeRegaloList extends State<TeRegaloList> {
  final RegaladosRepository repository = RegaladosRepository();
  final MadioRepository madiorepository = MadioRepository();
  Budget budget = const Budget(initialBudget: 20, finalBudget: 200);
  List<Recommendation> recommendations = [];
  List<ProductToShow> productsToShowList = [];
  List<ProductToShow> productsToShowListLimited = [];
  String recommendationHeader = '';
  String recommendationFooter = '';
  bool tryAgain = false;

  @override
  void initState() {
    super.initState();
    fetchRecommendationsData();
    fetchProductsData();
  }

  Future<void> fetchRecommendationsData() async {
    try {
      final loadedRecommendationSring =
          await repository.getAIRecommendationsString(widget.regalado, budget);
      final loadedRecommendations =
          parseRecommendations(loadedRecommendationSring.first);
      setState(() {
        recommendations = loadedRecommendations;
      });
    } catch (e) {
      print(e);
      setState(() {
        tryAgain = true;
      });
      throw Exception(e);
    }
  }

  Future<void> fetchProductsData() async {
    final loadedProductsToShow = await madiorepository.getProdcutsToShow();
    productsToShowList = loadedProductsToShow;
    setState(() {
      if (loadedProductsToShow.length < 3) {
        productsToShowList = loadedProductsToShow;
      } else {
        productsToShowListLimited = loadedProductsToShow.sublist(0, 3);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listas te Regalo'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 52, 32, 84),
              Color.fromARGB(197, 52, 32, 84),
            ], begin: Alignment.bottomLeft, end: Alignment.topLeft),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false, // set it to false
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 129, 147, 196),
              Color.fromARGB(255, 244, 242, 247),
              Color.fromARGB(255, 129, 147, 196),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
          child: Column(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Color.fromARGB(96, 174, 241, 255),
                      elevation: 8,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            child: const Icon(Icons.cake),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(20),
                              child: Text(widget.regalado.name),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                ElevatedButton(
                                  child: Text('presupuesto'),
                                  style: TextButton.styleFrom(
                                    primary: Color.fromARGB(255, 229, 223, 231),
                                    backgroundColor: Color.fromARGB(
                                        255, 66, 6, 73), // Background Color
                                  ),
                                  onPressed: () {
                                    budgetDialog();
                                  },
                                ),
                                Text(
                                    '${budget.initialBudget} - ${budget.finalBudget}'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Card(
                        elevation: 10,
                        color: Color.fromARGB(255, 255, 255, 255),
                        child: Column(
                          children: [
                            const Card(
                              elevation: 10,
                              child: Text('Lista de deseos'),
                              color: Color.fromARGB(7, 0, 0, 0),
                            ),
                            const SizedBox(height: 10),
                            ListWishes(List.empty()),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (tryAgain)
                      Center(
                        child: TextButton(
                          child: Text('Try again'),
                          onPressed: () {
                            setState(() {
                              tryAgain = false;
                            });
                            fetchRecommendationsData();
                          },
                        ),
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Card(
                          elevation: 0,
                          child: Column(
                            children: [
                              const Card(
                                elevation: 10,
                                color: Color.fromARGB(138, 255, 251, 251),
                                child: Text(
                                  'Lista de recomendaciones (I.A)',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 10),
                              ListRecommended(
                                recommendations,
                                header: recommendationHeader,
                                footer: recommendationFooter,
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 5.0),
                      child: Card(
                        elevation: 10,
                        color: Color.fromARGB(255, 255, 255, 255),
                        child: Column(
                          children: [
                            const Card(
                              elevation: 10,
                              child: Text('Productos locales para regalar'),
                              color: Color.fromARGB(7, 0, 0, 0),
                            ),
                            const SizedBox(height: 10),
                            ListProductsToShow(productsToShowList),
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 1, 3, 5),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (ctx) => ExpandedList(
                                          listToExpand: ListProductsToShow(
                                              productsToShowList),
                                          lisTitle: 'Lista de productos',
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text('Ver Más'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Recommendation> parseRecommendations(String input) {
    final lines = input.split('\n');
    final recommendations = <Recommendation>[];

    for (final line in lines) {
      final trimmedLine = line.trim();
      if (trimmedLine.isNotEmpty) {
        final parts = trimmedLine.split(". ");
        final number = int.tryParse(parts[0]);
        if (number != null) {
          final titleAndDescription = parts[1].split(":");
          final title = titleAndDescription[0].trim();
          final description = titleAndDescription[1].trim();
          recommendationHeader = title;
          recommendationFooter = description;
          final recommendation = Recommendation(number, title, description);
          recommendations.add(recommendation);
        }
      }
    }

    return recommendations;
  }

  Future budgetDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("presupuesto"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text('Desde:'),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration:
                            InputDecoration(hintText: 'Ingresa un valor'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text('Hasta:'),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration:
                            InputDecoration(hintText: 'Ingresa un valor'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            actions: [TextButton(onPressed: () {}, child: Text('Aceptar'))],
          ));
}
