part of 'order_cart_bloc.dart';

@immutable
abstract class OrderCartBlocEvent {}

class LoadOrderDetails extends OrderCartBlocEvent {
  LoadOrderDetails();
}

class DisplayOrderQuantity extends OrderCartBlocEvent {
  DisplayOrderQuantity();
}

class SaveOrderDetail extends OrderCartBlocEvent {
  final OrderDetail orderDetail;
  SaveOrderDetail({required this.orderDetail});
}

class DeleteProductFromOrder extends OrderCartBlocEvent {
  final int indexToRemove;
  DeleteProductFromOrder(this.indexToRemove);
}

class DeleteOrderSent extends OrderCartBlocEvent {
  DeleteOrderSent();
}
