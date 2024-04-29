import 'package:admin/Data/service/product/product_functions.dart';

// import 'package:admin/Domain/models/product/get%20product%20model/get_product_model.dart';

import 'package:admin/domain/models/product/get_product_model/get_product_model.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:bloc/bloc.dart';

// import 'package:meta/meta.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  List<GetProductModel>? allProducts;

  ProductBloc() : super(LoadingProductState()) {
    on<FetchProductsEvent>((event, emit) async {
      try {
        ProductService productService = ProductService();

        List<GetProductModel> products = await productService.getProducts();

        allProducts = products;

        emit(LoadededProductState(products));
      } catch (e) {
        emit(ErrorProductState('Error Fetching Categories $e'));
      }
    });

    on<SearchProductsEvent>((event, emit) async {
      try {
        ProductService productService = ProductService();

        List<GetProductModel> searchResults =
            await productService.getSearchedProducts(event.query);

        emit(SearchProductsState(searchResults: searchResults));
      } catch (e) {
        emit(ErrorProductState('Error Searching Products $e'));
      }
    });
  }
}
