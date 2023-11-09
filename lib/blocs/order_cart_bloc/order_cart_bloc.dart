import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:te_regalo/model/order_detail.dart';

part 'order_cart_bloc_event.dart';
part 'order_cart_bloc_state.dart';

class OrderCartBloc extends Bloc<OrderCartBlocEvent, OrderCartBlocState> {
  OrderCartBloc() : super(OrderCartBlocState(orderDetails: [], 0)) {
    on<OrderCartBlocEvent>((event, emit) async {
      if (event is LoadOrderDetails) {
        emit(OrderCartBlocState(state.orderDetails.length,
            orderDetails: state.orderDetails));
      }
      if (event is DisplayOrderQuantity) {
        OrderCartBlocState(state.orderDetails.length,
            orderDetails: state.orderDetails);
      }
      if (event is SaveOrderDetail) {
        List<OrderDetail> savedOrderDetails = state.orderDetails;
        savedOrderDetails.add(event.orderDetail);
        emit(OrderCartBlocState(savedOrderDetails.length,
            orderDetails: savedOrderDetails));
      }
      if (event is DeleteProductFromOrder) {
        List<OrderDetail> listRemoved = state.orderDetails;
        listRemoved.removeAt(event.indexToRemove);
        emit(OrderCartBlocState(listRemoved.length, orderDetails: listRemoved));
      }
      if (event is DeleteOrderSent) {
        List<OrderDetail> listDeleted = [];
        emit(OrderCartBlocState(listDeleted.length, orderDetails: listDeleted));
      }
    });
  }
}
