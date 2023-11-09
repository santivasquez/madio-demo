import 'package:flutter/material.dart';
import 'package:te_regalo/model/recommendation.dart';

class RecommendationDetailScreen extends StatelessWidget {
  RecommendationDetailScreen({super.key, required this.recommendation});

  final Recommendation recommendation;

  @override
  Widget build(context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Recomendación'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 129, 147, 196),
              Color.fromARGB(255, 31, 7, 67)
            ], begin: Alignment.bottomLeft, end: Alignment.topLeft),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 129, 147, 196),
              Color.fromARGB(255, 244, 242, 247),
              Color.fromARGB(255, 129, 147, 196),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
          child: Column(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            recommendation.title,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
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
                            '${recommendation.description}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 100),
                          const Text(
                            'páginas web recomendadas:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'buscando ...',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Más información:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'buscando ...',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
