import 'package:flutter/material.dart';
import 'package:te_regalo/screens/login_screen.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.warning_amber_outlined),
          SizedBox(height: 30),
          Text('Calendar under construction'),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => LoginScreen(),
                ),
              );
            },
            child: Text('login'),
          )
        ],
      ),
    );
  }
}
