import 'package:flutter/material.dart';
import 'package:te_regalo/model/Regalado.dart';
import 'package:te_regalo/screens/regalados_list_screen/not_regalados_found.dart';
import 'package:te_regalo/screens/regalados_list_screen/regalado_list_row.dart';

class RegaladosList extends StatelessWidget {
  const RegaladosList(this.regalados, {super.key});

  final List<Regalado> regalados;

  @override
  Widget build(BuildContext context) {
    return regalados.isEmpty
        ? const NotRegaladosFound('No hay Regalados.. ')
        : Expanded(
            child: ListView.builder(
              itemCount: regalados.length,
              itemBuilder: (BuildContext context, int index) {
                final regalado = regalados[index];
                return RegaladoListRow(regalado);
              },
            ),
          );
  }
}
