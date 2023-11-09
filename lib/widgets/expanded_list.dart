import 'package:flutter/material.dart';

class ExpandedList extends StatelessWidget {
  const ExpandedList(
      {super.key, required this.listToExpand, required this.lisTitle});

  final Widget listToExpand;
  final String lisTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lisTitle),
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
      resizeToAvoidBottomInset: false, // set it to false
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 63, 90, 163),
              Color.fromARGB(255, 244, 242, 247),
              Color.fromARGB(255, 61, 83, 126),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 15),
              listToExpand,
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
