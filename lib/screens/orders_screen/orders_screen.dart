import 'package:flutter/material.dart';
import 'package:te_regalo/data/madio_repository.dart';
import 'package:te_regalo/model/order.dart';
import 'package:te_regalo/screens/orders_screen/orders_list.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final MadioRepository repository = MadioRepository();
  List<Order> orders = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    isLoading = true;
    try {
      final loadedOrders = await repository.getOrders();

      setState(() {
        orders = loadedOrders;
        isLoading = false;
      });
    } catch (e) {
      isLoading = false;
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Historial de pedidos',
          style: TextStyle(color: Color.fromARGB(255, 236, 223, 181)),
        ),
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 63, 90, 163),
            Color.fromARGB(255, 244, 242, 247),
            Color.fromARGB(255, 61, 83, 126),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: isLoading
            ? const Center(
                child: Column(
                  children: [
                    SizedBox(height: 200),
                    Text('Buscando pedidos ...'),
                    SizedBox(height: 16),
                    CircularProgressIndicator(),
                  ],
                ),
              )
            : Column(
                children: [
                  ListOrders(orders),
                ],
              ),
      ),
    );
  }
}
