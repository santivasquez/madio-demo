import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class HalfStackWidget extends StatefulWidget {
  final String header;
  final Widget body;

  const HalfStackWidget({super.key, required this.header, required this.body});

  @override
  State<HalfStackWidget> createState() => _HalfStackWidgetState();

  static show({
    required BuildContext context,
    Color backGroundColor = const Color.fromRGBO(0, 35, 60, 0.8),
    required String headerText,
    required Widget body,
  }) {
    showMaterialModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: ((context) {
        return HalfStackWidget(header: headerText, body: body);
      }),
    );
  }
}

class _HalfStackWidgetState extends State<HalfStackWidget> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var sheetheight = (height * 0.85);

    return Container(
      color: Colors.transparent,
      height: sheetheight,
      child: Column(children: [
        Container(
          height: 5,
          width: 36,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        SizedBox(height: 5),
        Container(
          height: sheetheight - 10,
          width: double.infinity,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Text('Titulo')],
          ),
        )
      ]),
    );
  }
}
