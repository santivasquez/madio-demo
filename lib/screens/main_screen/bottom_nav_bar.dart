import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key, required this.currentIndex}) : super(key: key);

  final Function currentIndex;
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int index = 2;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 18, 0, 46),
            Color.fromARGB(239, 52, 32, 84),
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topLeft,
        ),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.shifting,
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
            widget.currentIndex(index);
          });
        },
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard_outlined),
            activeIcon: Icon(Icons.card_giftcard,
                color: Color.fromARGB(255, 225, 199, 165)),
            label: 'Regalados',
            backgroundColor: Colors.transparent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            activeIcon: Icon(Icons.calendar_month,
                color: Color.fromARGB(255, 225, 199, 165)),
            label: 'Calendario',
            backgroundColor: Colors.transparent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            activeIcon: Icon(Icons.shopping_bag,
                color: Color.fromARGB(255, 225, 199, 165)),
            label: 'Tiendas',
            backgroundColor: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
