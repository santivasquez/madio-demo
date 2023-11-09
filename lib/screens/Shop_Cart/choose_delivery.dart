import 'package:flutter/material.dart';
import 'package:te_regalo/data/logistics_repository.dart';
import 'package:te_regalo/model/address.dart';
import 'package:te_regalo/model/delivery_price.dart';
import 'package:te_regalo/model/order.dart';

class ChooseDelivery extends StatefulWidget {
  const ChooseDelivery(
    this.order,
    this.address, {
    super.key,
  });

  final Order? order;
  final Address? address;

  @override
  State<ChooseDelivery> createState() => _ChooseDeliveryState();
}

class _ChooseDeliveryState extends State<ChooseDelivery> {
  final LogisticsRepository repository = LogisticsRepository();
  List<DeliveryPrice> deliveriesPrice = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final loadedDeliveriesPrice = await repository.askForDeliveryPrice();

    setState(() {
      deliveriesPrice = loadedDeliveriesPrice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Escoge el envío'),
      insetPadding: const EdgeInsets.symmetric(horizontal: 8),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      content: deliveriesPrice.isEmpty
          ? SizedBox(
              height: 70,
              child: Column(
                children: const [
                  Text('Buscando cotización de envío...'),
                  SizedBox(height: 10),
                  CircularProgressIndicator()
                ],
              ),
            )
          : SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: deliveriesPrice.length,
                      itemBuilder: (BuildContext context, int index) {
                        final deliveryCompany = deliveriesPrice[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: ListTile(
                            leading: Image.network(
                              deliveryCompany.logoTransportadora,
                              width: 40,
                            ),
                            title: Text(deliveryCompany.nombreTransportadora),
                            subtitle: Text(
                                'Días entrega: ${deliveryCompany.diasentrega}'),
                            trailing:
                                Text('Valor: \$${deliveryCompany.valorTotal}'),
                            onTap: () {
                              addDeliveryPrice(deliveryCompany);
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancelar'),
        ),
      ],
    );
  }

  addDeliveryPrice(DeliveryPrice deliveryPrice) {
    Navigator.of(context).pop(deliveryPrice);
  }
}
