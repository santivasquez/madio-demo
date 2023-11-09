import 'package:flutter/material.dart';

class LoadingFullScreen extends StatelessWidget {
  final String textToShow;

  const LoadingFullScreen({super.key, required this.textToShow});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(220, 159, 168, 218),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text(
                  textToShow,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      height: 1, fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              CircularProgressIndicator(),
            ],
          ),
        ],
      ),
    );
  }
}
