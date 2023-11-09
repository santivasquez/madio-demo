import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:te_regalo/blocs/order_cart_bloc/order_cart_bloc.dart';
import 'package:te_regalo/screens/Shop_Cart/shop_cart_screen.dart';
import 'package:te_regalo/screens/about_us_screen/about_us_screen.dart';
import 'package:te_regalo/screens/main_screen/bottom_nav_bar.dart';
import 'package:te_regalo/screens/main_screen/nav_bar_routes.dart';
import 'package:te_regalo/screens/orders_screen/orders_screen.dart';
import 'package:badges/badges.dart' as badges;
import 'package:te_regalo/screens/user_screen/user_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 2;
  BottomNavBar? bNavBar;

  @override
  void initState() {
    bNavBar = BottomNavBar(currentIndex: (i) {
      setState(() {
        index = i;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Te Regalo',
            style: GoogleFonts.getFont('Permanent Marker'),
            //style: TextStyle(color: Color.fromARGB(255, 236, 223, 181)),
          ),
          actions: [
            BlocBuilder<OrderCartBloc, OrderCartBlocState>(
              builder: (context, state) {
                return badges.Badge(
                  position: badges.BadgePosition.topEnd(top: 0, end: 0),
                  badgeAnimation: const badges.BadgeAnimation.rotation(
                    animationDuration: Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn,
                  ),
                  badgeContent: Text(
                    state.orderQty.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.shopping_cart_outlined),
                    onPressed: () {
                      _goToShoppingCart(context);
                    },
                  ),
                );
              },
            ),
            PopupMenuButton(
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 0,
                  child: Text('Mi perfil'),
                ),
                const PopupMenuItem(
                  value: 1,
                  child: Text('Ver pedidos'),
                ),
                const PopupMenuItem(
                  value: 2,
                  child: Text('sobre nosotros'),
                ),
                const PopupMenuItem(
                  value: 3,
                  child: Text('Cerrar sesión'),
                ),
              ],
              onSelected: (result) async {
                if (result == 0) {
                  _goToUserScreen(context);
                }
                if (result == 1) {
                  _goToMyOrders(context);
                }
                if (result == 2) {
                  _goToAboutUsScreen(context);
                }
                if (result == 3) {
                  await FirebaseAuth.instance.signOut();
                }
              },
            ),
          ],
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 52, 32, 84),
                Color.fromARGB(255, 18, 0, 46),
              ], begin: Alignment.bottomLeft, end: Alignment.topLeft),
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 244, 242, 247),
              Color.fromARGB(255, 244, 242, 247),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
          child: NavBarRoutes(index: index),
        ),
        bottomNavigationBar: bNavBar);
  }

  void _goToShoppingCart(BuildContext context) async {
    bool? result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => BlocBuilder<OrderCartBloc, OrderCartBlocState>(
          builder: (context, state) {
            return ShopCartScreen(orderDetails: state.orderDetails);
          },
        ),
      ),
    );

    if (result != null && result) {
      // ir a mis pedidos
    }
  }

  void _goToMyOrders(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => const OrdersScreen()),
    );
  }

  void _goToUserScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => const UserScreen()),
    );
  }

  void _goToAboutUsScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => const AboutUsScreen()),
    );
  }
}
