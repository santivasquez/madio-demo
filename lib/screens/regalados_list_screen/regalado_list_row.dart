import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:te_regalo/model/Regalado.dart';
import 'package:te_regalo/screens/te_regalo_lists/te_regalo_list.dart';

class RegaladoListRow extends StatelessWidget {
  const RegaladoListRow(this.regalado, {super.key});

  final Regalado regalado;

  @override
  Widget build(BuildContext context) {
    String celebration = '';
    String month = '';
    String day = '';
    final celebrations = regalado.cdates;
    if (celebrations != null) {
      if (celebrations.isNotEmpty) {
        celebration = celebrations.first.occasion;
        month = DateFormat.MMMM().format(celebrations.first.date);
        day = DateFormat.d().format(celebrations.first.date);
      }
    }
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 8,
        shadowColor: const Color.fromARGB(255, 0, 0, 0),
        color: Colors.transparent,
        child: ListTile(
          tileColor: Color.fromARGB(115, 174, 241, 255),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          leading: Container(
              width: 100,
              padding: const EdgeInsets.only(right: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    celebration,
                    style: GoogleFonts.getFont('Lobster'),
                  ),
                  Text(
                    '$day $month',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              )),
          title: Text(
            regalado.name,
            style: GoogleFonts.getFont('Skranji'),
          ),
          subtitle: Text(regalado.lastName),
          trailing: const Icon(Icons.keyboard_arrow_right,
              color: Color.fromARGB(255, 0, 0, 0), size: 30.0),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (ctx) => TeRegaloList(regalado)));
          },
        ));
  }
}
