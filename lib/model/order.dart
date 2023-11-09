import 'package:te_regalo/model/order_detail.dart';

class Order {
  String id;
  DateTime date;
  String userId;
  String addressId;
  String status;
  String idSeller;
  String idShop;
  List<OrderDetail> orderDetails;
  String observations;

  Order({
    required this.id,
    required this.date,
    required this.userId,
    required this.addressId,
    required this.status,
    required this.idSeller,
    required this.idShop,
    required this.orderDetails,
    required this.observations,
  });

  Map<String, dynamic> toJson() {
    return {
      "date": date.toIso8601String(),
      "id_user": userId,
      "id_address": addressId,
      "id_status": status,
      "id_seller": idSeller,
      "id_store": idShop,
      "id_payment_type": "uaYoUpmQYh0CpqFB9eWP",
      "order_details":
          orderDetails.map((detail) => detail.toJsonOrder()).toList(),
      "observations": observations,
    };
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      date: DateTime(1, 1, 1), // TODO desde el back
      userId: json['id_user'],
      addressId: json['id_address'],
      status: json['id_status'],
      idSeller: json['id_seller'],
      idShop: json['id_store'],
      orderDetails: List<OrderDetail>.from(
          json['order_details'].map((x) => OrderDetail.fromJson(x))),
      observations: json['observations'],
    );
  }
}
