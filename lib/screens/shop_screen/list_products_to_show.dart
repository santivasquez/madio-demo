import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:te_regalo/model/product_to_show.dart';
import 'package:te_regalo/screens/shop_screen/product_to_show_detail_screen.dart';

class ListProductsToShow extends StatelessWidget {
  const ListProductsToShow(this.productsToShowList, {super.key});

  final List<ProductToShow> productsToShowList;

  @override
  Widget build(BuildContext context) {
    return productsToShowList.isEmpty
        ? const Center(child: Text('No hay productos para mostrar.'))
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: productsToShowList.length,
            itemBuilder: (BuildContext context, int index) {
              final name = productsToShowList[index].product.name;
              final photo = productsToShowList[index].product.images.first;
              final price = productsToShowList[index].price.price;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 8,
                  shadowColor: const Color.fromARGB(255, 0, 0, 0),
                  color: Color.fromARGB(115, 174, 241, 255),
                  child: ListTile(
                    leading: Image.network(photo),
                    title: Text(
                      name,
                      style: GoogleFonts.getFont('Skranji'),
                    ),
                    subtitle: Text('\$ $price'),
                    trailing: const Icon(Icons.lens_blur,
                        color: Color.fromARGB(255, 0, 0, 0), size: 30.0),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => ProductToshowDetailScreen(
                              productToShow: productsToShowList[index]),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
  }
}
