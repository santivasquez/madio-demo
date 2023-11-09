import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:te_regalo/blocs/order_cart_bloc/order_cart_bloc.dart';
import 'package:te_regalo/data/madio_repository.dart';
import 'package:te_regalo/model/order_detail.dart';
import 'package:te_regalo/model/product_to_show.dart';
import 'package:te_regalo/widgets/add_quantity_dialog.dart';
import 'package:te_regalo/widgets/loaging_full_screen.dart';

class ProductToshowDetailScreen extends StatefulWidget {
  ProductToshowDetailScreen({super.key, required this.productToShow});

  final ProductToShow productToShow;

  @override
  State<ProductToshowDetailScreen> createState() =>
      _ProductToshowDetailScreenState();
}

class _ProductToshowDetailScreenState extends State<ProductToshowDetailScreen> {
  final MadioRepository repository = MadioRepository();

  bool isLoading = false;

  @override
  Widget build(context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.productToShow.product.name),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 52, 32, 84),
              Color.fromARGB(255, 18, 0, 46),
            ], begin: Alignment.bottomLeft, end: Alignment.topLeft),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 255, 255, 255),
                  Color.fromARGB(255, 244, 242, 247),
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              ),
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.network(
                          widget.productToShow.product.images.first.trim(),
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.productToShow.product.name,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Precio: \$${widget.productToShow.price.price.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue,
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Description:',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                widget.productToShow.product.description,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            showQuantityDialog(context, widget.productToShow);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(16),
                            primary: Colors.blue,
                          ),
                          child: const Text(
                            'Agregar al Carrito',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
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
          isLoading
              ? LoadingFullScreen(
                  textToShow:
                      'Agregando producto a Carrito de Compras.\n\nValidando inventario..')
              : SizedBox(),
        ],
      ),
    );
  }

  void showQuantityDialog(context, ProductToShow productToShow) async {
    final int? selectedQuantity = await showDialog(
      context: context,
      builder: (context) => QuantityDialog(initialQuantity: 1),
    );
    if (selectedQuantity != null) {
      if (await validateProduct(context, productToShow, selectedQuantity)) {
        addproductTocart(productToShow, selectedQuantity, context);
        Navigator.pop(context);
      } else {
        showErrorDialog(context, 'Ya no queda inventario para este producto.');
      }
    }
  }

  Future<bool> validateProduct(
      context, ProductToShow productToShow, int cant) async {
    setState(() {
      isLoading = true;
    });
    try {
      final loadedProductsToShow =
          await repository.validateProdcutToShow(productToShow, cant);
      setState(() {
        isLoading = false;
      });
      return loadedProductsToShow;
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
      showErrorDialog(
          context, 'No se pudo consultar el inventario disponible.');
      return false;
    }
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Lo sentimos.'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void addproductTocart(ProductToShow productToShow, int qty, context) {
    final orderDetail = OrderDetail(
      id: '',
      orderId: '',
      product: productToShow.product,
      productPrice: productToShow.price,
      quantity: qty,
    );
    BlocProvider.of<OrderCartBloc>(context)
        .add(SaveOrderDetail(orderDetail: orderDetail));
  }
}
