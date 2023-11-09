import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:te_regalo/blocs/order_cart_bloc/order_cart_bloc.dart';
import 'package:te_regalo/data/madio_repository.dart';
import 'package:te_regalo/data/registry_repository.dart';
import 'package:te_regalo/model/address.dart';
import 'package:te_regalo/model/delivery_price.dart';
import 'package:te_regalo/model/order.dart';
import 'package:te_regalo/model/order_detail.dart';
import 'package:te_regalo/screens/Shop_Cart/add_address_dialog.dart';
import 'package:te_regalo/screens/Shop_Cart/choose_delivery.dart';
import 'package:te_regalo/widgets/loaging_full_screen.dart';

class ShopCartScreen extends StatefulWidget {
  const ShopCartScreen({super.key, required this.orderDetails});

  final List<OrderDetail> orderDetails;

  @override
  State<ShopCartScreen> createState() => _ShopCartScreenState();
}

class _ShopCartScreenState extends State<ShopCartScreen> {
  List<Address> addressesList = [];
  final observationsController = TextEditingController();
  final selectedAddressController = TextEditingController();
  final RegistryRepository repository = RegistryRepository();
  final MadioRepository madioRepository = MadioRepository();
  Address? selectedAddress;
  DeliveryPrice? selectedDeliveryPrice;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final loadedAddresses = await repository.getAddresses();

    setState(() {
      addressesList = loadedAddresses;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Carrito de compras',
            style: TextStyle(color: Color.fromARGB(255, 236, 223, 181)),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart)),
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
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 255, 255, 255),
                  Color.fromARGB(255, 244, 242, 247),
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              ),
              child: widget.orderDetails.isEmpty
                  ? const Center(
                      child: Text("No has agregado productos aún"),
                    )
                  : SingleChildScrollView(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          children: [
                            const SizedBox(height: 16),
                            Container(
                              color: Color.fromARGB(0, 255, 255, 255),
                              child: Center(
                                child: Column(
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: () async {
                                        Address? submittedText =
                                            await showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) =>
                                              AddAddressDialog(),
                                        );
                                        if (submittedText != null) {
                                          setState(() {
                                            addressesList.add(submittedText);
                                          });
                                        }
                                      },
                                      style: TextButton.styleFrom(
                                        primary:
                                            Color.fromARGB(255, 229, 223, 231),
                                        backgroundColor: Color.fromARGB(
                                            255, 66, 6, 73), // Background Color
                                      ),
                                      icon: Icon(Icons.add_circle_outline),
                                      label: Text('Crear dirección'),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        const Text(
                                          'Dirección \nde entrega : ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Color.fromARGB(255, 5, 5, 5),
                                              fontSize: 16),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        addressesList.isEmpty
                                            ? const Text(
                                                'No hay direcciones',
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 149, 0, 0),
                                                    fontSize: 18),
                                              )
                                            : Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 16),
                                                  child:
                                                      DropdownButtonFormField2<
                                                          String>(
                                                    isExpanded: true,
                                                    decoration: InputDecoration(
                                                      // Add Horizontal padding using menuItemStyleData.padding so it matches
                                                      // the menu padding when button's width is not specified.
                                                      contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              vertical: 10),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      // Add more decoration..
                                                    ),
                                                    hint: const Text(
                                                      'Selecciona Dirección',
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                    ),
                                                    items: addressesList.map(
                                                      (addres) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: addres.id,
                                                          child: Text(
                                                              addres.title),
                                                        );
                                                      },
                                                    ).toList(),
                                                    onChanged: (topic) {
                                                      if (topic != null) {
                                                        selectedAddressController
                                                            .text = topic;
                                                        print(
                                                            'addres: ' + topic);
                                                        setState(() {
                                                          selectedAddress =
                                                              addressesList.firstWhere(
                                                                  (address) =>
                                                                      address
                                                                          .id ==
                                                                      topic);
                                                          ;
                                                        });
                                                      }
                                                    },
                                                  ),
                                                ),
                                              )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            _showAddressDetail(selectedAddress),
                            const SizedBox(height: 16),
                            const Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 32),
                              child: Divider(height: 2, thickness: 2),
                            ),
                            const SizedBox(height: 16),
                            _showPaymentTypes(),
                            const SizedBox(height: 16),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 32),
                              child: Divider(height: 2, thickness: 2),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton.icon(
                              onPressed: () async {
                                DeliveryPrice? submittedDelivery =
                                    await showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) =>
                                            ChooseDelivery(null, null));
                                if (submittedDelivery != null) {
                                  setState(() {
                                    selectedDeliveryPrice = submittedDelivery;
                                  });
                                }
                              },
                              style: TextButton.styleFrom(
                                primary: Color.fromARGB(255, 229, 223, 231),
                                backgroundColor: Color.fromARGB(
                                    255, 66, 6, 73), // Background Color
                              ),
                              icon: Icon(Icons.local_shipping),
                              label: Text('Escoger envío'),
                            ),
                            _showDeliveryPrice(selectedDeliveryPrice),
                            const SizedBox(height: 16),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 32),
                              child: Divider(height: 2, thickness: 2),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Productos escogidos:',
                              textAlign: TextAlign.left,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Expanded(child: _buildCartList()),
                            Container(
                              color: const Color.fromARGB(0, 33, 149, 243),
                              height: 130, // Replace with the height you want
                              child: Center(
                                child: Column(
                                  children: [
                                    const Text(
                                      'comentarios sobre el pedido',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 18),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 5, 20, 10),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        elevation: 8,
                                        child: TextFormField(
                                          controller: observationsController,
                                          minLines: 2,
                                          maxLines: 2,
                                          keyboardType: TextInputType.multiline,
                                          decoration: const InputDecoration(
                                              hintText:
                                                  'Ingresa un comentario adicional',
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10)))),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
            isLoading
                ? LoadingFullScreen(
                    textToShow: 'Creando Pedido..\n\nValidando inventario..')
                : SizedBox(),
          ],
        ),
        bottomNavigationBar: Row(
          children: [
            _buildTotalPrice(),
            widget.orderDetails.isNotEmpty
                ? ElevatedButton(
                    onPressed: !isLoading
                        ? () {
                            _sendOrder(widget.orderDetails);
                          }
                        : null,
                    child: const Text('Comprar'),
                  )
                : const SizedBox()
          ],
        ));
  }

  Widget _showAddressDetail(Address? address) {
    if (address == null) {
      return const SizedBox();
    }
    return Center(
        child: Row(
      children: [
        Text(
            ' ${address.address}, Barrio: ${address.neighborhood}, Ciudad: ${address.city}.'),
      ],
    ));
  }

  Widget _showPaymentTypes() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: [
          const Text(
            'Tipo de \nPago : ',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 5, 5, 5),
                fontSize: 16),
          ),
          Text('Contra entrega:'),
          Checkbox(
            value: true,
            onChanged: (bool? value) {},
          ),
          Text('Paypal:'),
          Checkbox(
            value: false,
            onChanged: null,
          ),
        ],
      ),
    );
  }

  Widget _showDeliveryPrice(DeliveryPrice? deliveryPrice) {
    if (deliveryPrice == null) {
      return const SizedBox();
    }
    return Center(
        child: Row(
      children: [
        Image.network(
          deliveryPrice.logoTransportadora,
          width: 40,
        ),
        Text(
            ' Diás: ${deliveryPrice.diasentrega} valor: \$${deliveryPrice.valorTotal}'),
      ],
    ));
  }

  Widget _buildCartList() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: widget.orderDetails.length,
      itemBuilder: (context, index) {
        final product = widget.orderDetails[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 8,
            color: Color.fromARGB(115, 174, 241, 255),
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
              trailing: IconButton(
                icon: const Icon(
                  Icons.delete_forever,
                  color: Colors.red,
                ),
                onPressed: () => _removeProduct(index),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTotalPrice() {
    double totalPrice = widget.orderDetails.fold(
        0,
        (sum, product) =>
            sum + (product.productPrice.price * product.quantity));
    totalPrice += selectedDeliveryPrice?.valorTotal ?? 0;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        'Precio total: \$${totalPrice.toStringAsFixed(2)}',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  void _removeProduct(int index) {
    setState(() {
      BlocProvider.of<OrderCartBloc>(context)
          .add(DeleteProductFromOrder(index));
    });
  }

  void _sendOrder(List<OrderDetail> orderDetails) async {
    setState(() {
      isLoading = true;
    });
    Order order = Order(
      id: '',
      date: DateTime.now(),
      userId: '',
      addressId: selectedAddressController.text,
      status: '1',
      idSeller: 'xHrNxVwCSKTVQu60xV0ocifEuk52',
      idShop: '123',
      orderDetails: orderDetails,
      observations: observationsController.text,
    );

    try {
      final orderSuccessful =
          await madioRepository.sendOrder(order, orderDetails);

      setState(() {
        isLoading = false;
      });
      if (orderSuccessful) {
        showOrderSuccessDialog(context);
      } else {
        showOrderProblemDialog(context, 'Algo malo pasó');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showOrderProblemDialog(context, e.toString());
    }
  }

  void showOrderProblemDialog(BuildContext context, String message) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error al crear Pedido'),
          content: Text(
              'Hubo un problema al crear o enviar el pedido,\nintente de nuevo. \n\n$message'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showOrderSuccessDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pedido Creado'),
          content: Text(
              'Su Orden se a enviado y creado Exitosamente.\n\nPuedes revisar el estado en Ver Pedidos'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                receivedSucess();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void receivedSucess() {
    BlocProvider.of<OrderCartBloc>(context).add(DeleteOrderSent());
    Navigator.of(context).pop();
  }
}
