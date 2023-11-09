import 'package:flutter/material.dart';
import 'package:te_regalo/data/registry_repository.dart';
import 'package:te_regalo/model/address.dart';

class AddAddressDialog extends StatefulWidget {
  @override
  _AddAddressDialogState createState() => _AddAddressDialogState();
}

class _AddAddressDialogState extends State<AddAddressDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _neighboorController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _infoController = TextEditingController();
  final RegistryRepository repository = RegistryRepository();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Crear Dirección'),
      insetPadding: const EdgeInsets.symmetric(horizontal: 8),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      content: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration:
                    const InputDecoration(labelText: 'Nombre de dirección'),
              ),
              TextField(
                controller: _textController,
                decoration: const InputDecoration(labelText: 'Dirección'),
              ),
              TextField(
                controller: _neighboorController,
                decoration: const InputDecoration(labelText: 'Barrio'),
              ),
              TextField(
                controller: _cityController,
                decoration: const InputDecoration(labelText: 'Ciudad'),
              ),
              TextField(
                controller: _infoController,
                decoration:
                    const InputDecoration(labelText: 'información adicional'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            saveAddress(
              Address(
                  id: '0',
                  idUser: '',
                  title: _titleController.text,
                  neighborhood: _neighboorController.text,
                  city: _cityController.text,
                  state: 'Antioquia',
                  country: 'Colombia',
                  address: _textController.text,
                  description: _infoController.text,
                  mapsUrl: 'google.maps'),
            );
          },
          child: Text('Agregar'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancelar'),
        ),
      ],
    );
  }

  void saveAddress(Address address) async {
    try {
      final saveAddress = await repository.saveAddress(address);
      Navigator.of(context).pop(saveAddress);
    } catch (e) {
      throw Exception(e);
    }
  }
}
