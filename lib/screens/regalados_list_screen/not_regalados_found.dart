import 'package:flutter/material.dart';

class NotRegaladosFound extends StatelessWidget {
  const NotRegaladosFound(this.message, {super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message),
    );
  }
}
