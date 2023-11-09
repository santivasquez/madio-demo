import 'package:flutter/material.dart';
import 'package:te_regalo/model/order.dart';
import 'package:te_regalo/model/order_detail.dart';

class ListOrders extends StatelessWidget {
  const ListOrders(this.ordersList, {super.key});

  final List<Order> ordersList;

  @override
  Widget build(BuildContext context) {
    return ordersList.isEmpty
        ? const Center(
            child: Text('Aún no has realizado pedidos'),
          )
        : Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: ordersList.length,
              itemBuilder: (BuildContext context, int index) {
                final order = ordersList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 8,
                    color: Color.fromARGB(109, 144, 98, 176),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Text('Orden: ${order.id}'),
                          //title: Text('Fecha: '),
                          //subtitle: Text('Observaciones: ${order.observations}'),
                          trailing: Text('Estado: ${order.status}'),
                          onTap: () {
                            //vamos a ver
                          },
                        ),
                        _buildCartList(order.orderDetails),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
  }

  Widget _buildCartList(List<OrderDetail> orderDetails) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: orderDetails.length,
      itemBuilder: (context, index) {
        final product = orderDetails[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 8,
            color: Color.fromARGB(255, 255, 255, 255),
            child: ListTile(
              leading: Image.network(product.product.images.first),
              title: Text(product.product.name),
              subtitle: Row(
                children: [
                  Text('Cant: '),
                  Text(product.quantity.toString()),
                  Text('  Precio: '),
                  Text(' \$ ' + product.productPrice.price.toString()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
