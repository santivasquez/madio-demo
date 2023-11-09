import 'package:flutter/material.dart';
import 'package:te_regalo/data/regalados_repository.dart';
import 'package:te_regalo/model/Regalado.dart';
import 'package:te_regalo/screens/add_regalados/regalados_form.dart';
import 'package:te_regalo/screens/regalados_list_screen/list_ragalados.dart';

class RegaladosScreen extends StatefulWidget {
  @override
  _RegaladosScreenState createState() => _RegaladosScreenState();
}

class _RegaladosScreenState extends State<RegaladosScreen> {
  List<Regalado> regalados = [];
  final RegaladosRepository repository = RegaladosRepository();
  bool tryAgain = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final loadedRegalados = await repository.getRegalados();

      setState(() {
        regalados = loadedRegalados;
      });
    } catch (e) {
      print(e);
      setState(() {
        tryAgain = true;
      });
      throw Exception(e);
    }
  }

  void _addregalado(BuildContext context) async {
    bool? result = await Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => const RegaladoForm()),
    );

    if (result != null && result) {
      fetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: () {
            _addregalado(context);
          },
          style: TextButton.styleFrom(
            primary: Color.fromARGB(255, 229, 223, 231),
            backgroundColor: Color.fromARGB(255, 66, 6, 73), // Background Color
          ),
          icon: Icon(Icons.person_add),
          label: Text('Agregar regalado'),
        ),
        const SizedBox(height: 10),
        if (tryAgain)
          Center(
            child: TextButton(
              child: Text('Try again'),
              onPressed: () {
                setState(() {
                  tryAgain = false;
                });
                fetchData();
              },
            ),
          )
        else
          RegaladosList(regalados),
      ],
    );
  }
}
