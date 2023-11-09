part of 'order_cart_bloc.dart';

class OrderCartBlocState {
  final List<OrderDetail> orderDetails;
  final int orderQty;

  OrderCartBlocState(this.orderQty, {required this.orderDetails});
}
