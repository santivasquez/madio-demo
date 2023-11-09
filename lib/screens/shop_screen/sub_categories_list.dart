import 'package:flutter/material.dart';
import 'package:te_regalo/model/sub_category.dart';

class SubCategoriesList extends StatelessWidget {
  final List<SubCategory> subcategories;
  final String selected;
  final Function(String) selectedSubCategories;

  const SubCategoriesList({
    super.key,
    required this.subcategories,
    required this.selected,
    required this.selectedSubCategories,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: subcategories.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              if (subcategories[index].id == selected)
                Container(
                  height: 80,
                  width: 160,
                  color: Color.fromARGB(34, 85, 4, 155),
                ),
              Container(
                width: 160,
                height: 80,
                child: Card(
                  elevation: 10,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 255, 255, 255),
                    ),
                    onPressed: (() {
                      selectedSubCategories(subcategories[index].id);
                    }),
                    child: Row(
                      children: [
                        Expanded(
                          child: FadeInImage(
                            image: NetworkImage(subcategories[index].imageUrl),
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
                          child: Text(subcategories[index].name),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
