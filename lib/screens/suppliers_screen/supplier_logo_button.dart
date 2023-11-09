import 'package:flutter/material.dart';
import 'package:te_regalo/model/supplier.dart';

class SupplierLogoButton extends StatelessWidget {
  final Supplier supplier;
  final Function(BuildContext, Supplier) selectedSupplier;

  const SupplierLogoButton(
      {super.key, required this.supplier, required this.selectedSupplier});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
      elevation: 8,
      child: InkWell(
        onTap: () {
          selectedSupplier(context, supplier);
        },
        child: ClipOval(
          child: FadeInImage(
            placeholder:
                const AssetImage('assets/images/No-Image-Placeholder.png'),
            image: NetworkImage(supplier.logoUrl),
            fit: BoxFit.cover,
            placeholderErrorBuilder: (context, error, stackTrace) =>
                Image.asset('assets/images/No-Image-Placeholder.png'),
            imageErrorBuilder: (context, error, stackTrace) =>
                Image.asset('assets/images/No-Image-Placeholder.png'),
          ),
        ),
      ),
    );
  }
}
