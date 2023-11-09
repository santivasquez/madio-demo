import 'package:flutter/material.dart';
import 'package:te_regalo/model/supplier.dart';
import 'package:te_regalo/screens/suppliers_screen/supplier_logo_button.dart';

class SuppliersList extends StatelessWidget {
  final List<Supplier> suppliers;
  final Function(BuildContext, Supplier) selectedSupplier;

  const SuppliersList(
      {super.key, required this.suppliers, required this.selectedSupplier});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: suppliers.length,
        itemBuilder: ((context, index) {
          return SizedBox(
            height: 80,
            width: 80,
            child: SupplierLogoButton(
              supplier: suppliers[index],
              selectedSupplier: selectedSupplier,
            ),
          );
        }),
      ),
    );
  }
}
