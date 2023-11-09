import 'package:flutter/material.dart';
import 'package:te_regalo/model/category.dart';

class CategoriesList extends StatelessWidget {
  final List<Category> categories;
  final String selected;
  final Function(String) selectedCategories;

  const CategoriesList(
      {super.key,
      required this.categories,
      required this.selectedCategories,
      required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: ((context, index) {
          return Stack(
            children: [
              if (categories[index].id == selected)
                Container(
                  height: 100,
                  width: 120,
                  color: Color.fromARGB(34, 85, 4, 155),
                ),
              Container(
                width: 120,
                height: 80,
                child: Card(
                  elevation: 10,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 255, 255, 255),
                    ),
                    onPressed: (() {
                      selectedCategories(categories[index].id);
                    }),
                    child: Column(
                      children: [
                        Expanded(
                          child: FadeInImage(
                            image: NetworkImage(categories[index].imageUrl),
                            placeholder: AssetImage(
                                "assets/images/No-Image-Placeholder.png"),
                            imageErrorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/images/No-Image-Placeholder.png',
                                fit: BoxFit.fill,
                              );
                            },
                            fit: BoxFit.fill,
                          ),
                        ),
                        Card(
                          child: Text(categories[index].name),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
