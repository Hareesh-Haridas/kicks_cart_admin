import 'package:admin/Data/service/order/order_functions.dart';


import 'package:admin/Domain/models/order/get_order_model.dart';


import 'package:bloc/bloc.dart';


import 'package:meta/meta.dart';


part 'orders_event.dart';


part 'orders_state.dart';


class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {

  OrdersBloc() : super(LoadingOrdersState()) {

    on<FetchOrdersEvent>((event, emit) async {

      try {

        OrderService orderService = OrderService();


        List<GetOrderModel> orders = await orderService.getOrders();


        print('Name ${orders.length}');


        emit(LoadedOrderState(orders: orders));

      } catch (e) {

        emit(ErrorOrderState(error: 'Error Fetching Orders $e'));

      }

    });

  }

}

