part of 'orders_bloc.dart';

@immutable
sealed class OrdersState {}

final class OrdersInitial extends OrdersState {}

class LoadingOrdersState extends OrdersState {}

class LoadedOrderState extends OrdersState {
  final List<GetOrderModel> orders;

  LoadedOrderState({required this.orders});
}

class ErrorOrderState extends OrdersState {
  final String error;

  ErrorOrderState({required this.error});
}
