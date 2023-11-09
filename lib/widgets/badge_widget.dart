import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:te_regalo/blocs/order_cart_bloc/order_cart_bloc.dart';

class BadgeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCartBloc, OrderCartBlocState>(
      builder: (context, badgeValue) {
        return Stack(
          alignment: Alignment.topRight,
          children: [
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                // Implement your notification handling logic here.
              },
            ),
            if (badgeValue.orderQty > -1)
              CircleAvatar(
                backgroundColor: Colors.red,
                radius: 10,
                child: Text(
                  badgeValue.orderQty.toString(),
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
          ],
        );
      },
    );
  }
}
