import 'package:flutter/material.dart';

class QuantityDialog extends StatefulWidget {
  final int initialQuantity;

  QuantityDialog({required this.initialQuantity});

  @override
  _QuantityDialogState createState() => _QuantityDialogState();
}

class _QuantityDialogState extends State<QuantityDialog> {
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    _quantity = widget.initialQuantity;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text('Selecciona cantidad')),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
              setState(() {
                if (_quantity > 1) {
                  _quantity--;
                }
              });
            },
          ),
          Text(
            '$_quantity',
            style: TextStyle(fontSize: 20),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                _quantity++;
              });
            },
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          child: Text('Cancelar'),
          onPressed: () {
            Navigator.pop(context, null);
          },
        ),
        ElevatedButton(
          child: Text('Agregar'),
          onPressed: () {
            Navigator.pop(context, _quantity);
          },
        ),
      ],
    );
  }
}
