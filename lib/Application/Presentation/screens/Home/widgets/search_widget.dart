import 'package:admin/Application/Business%20logic/product/bloc/bloc/product_bloc.dart';
import 'package:admin/Domain/models/product/get%20product%20model/get_product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchWidget extends StatelessWidget {
  SearchWidget({
    super.key,
  });
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        controller: searchController,
        onChanged: (value) {
          context.read<ProductBloc>().add(SearchProductsEvent(query: value));
        },
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
              onPressed: () {
                searchController.clear();
                context.read<ProductBloc>().add(SearchProductsEvent(query: ""));
              },
              icon: const Icon(Icons.clear)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(115),
          ),
          hintText: 'Search Product',
        ),
      ),
    );
  }
}

//List<String> productNames = [];

List<GetProductModel> products = [];

List<GetProductModel> filterProducts(String query) {
  print(products);
  return products
      .where(
          (product) => product.name.toLowerCase().contains(query.toLowerCase()))
      .toList();
}
