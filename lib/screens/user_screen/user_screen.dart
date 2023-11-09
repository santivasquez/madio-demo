import 'package:flutter/material.dart';
import 'package:te_regalo/data/madio_repository.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final MadioRepository repository = MadioRepository();

  @override
  void initState() {
    super.initState();
    //fetchData();
  }

  Future<void> fetchData() async {
    try {
      //final loadedOrders = await repository.getOrders();

      setState(() {
        //orders = loadedOrders;
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Usuario',
          style: TextStyle(color: Color.fromARGB(255, 236, 223, 181)),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 129, 147, 196),
              Color.fromARGB(255, 101, 17, 226)
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
        child: Center(child: Text('Info del usuario')),
      ),
    );
  }
}
