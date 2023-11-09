import 'package:flutter/material.dart';
import 'package:te_regalo/screens/calendar_screen/calendar_screen.dart';
import 'package:te_regalo/screens/regalados_list_screen/regalados_screen.dart';
import 'package:te_regalo/screens/shop_screen/shop_screen.dart';

class NavBarRoutes extends StatelessWidget {
  final int index;

  const NavBarRoutes({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    List<Widget> myList = [
      RegaladosScreen(),
      const CalendarScreen(),
      ShopScreen(),
    ];
    return IndexedStack(
      index: index,
      children: myList,
    );
  }
}
