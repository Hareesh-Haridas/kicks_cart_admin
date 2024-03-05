part of 'product_bloc.dart';


@immutable

sealed class ProductState {}


final class ProductInitial extends ProductState {}


class LoadingProductState extends ProductState {}


class LoadededProductState extends ProductState {

  final List<GetProductModel> products;


  LoadededProductState(this.products);

}


class ErrorProductState extends ProductState {

  final String error;


  ErrorProductState(this.error);

}


class SearchProductsState extends ProductState {

  final List<GetProductModel>? searchResults;


  SearchProductsState({required this.searchResults});

}


class ErrorSearchProductState extends ProductState {

  final String error;


  ErrorSearchProductState({required this.error});

}

