// import 'package:admin/Application/Business%20logic/product/bloc/bloc/product_bloc.dart';
import 'package:admin/application/business_logic/product/bloc/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchWidget extends StatefulWidget {
  final BuildContext context;
  final Function(String) onSearch;
  const SearchWidget({
    super.key,
    required this.onSearch,
    required this.context,
  });

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        controller: searchController,
        onChanged: (query) {
          widget.onSearch(query);
        },
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
              onPressed: () {
                searchController.clear();
                widget.onSearch('');
                widget.context.read<ProductBloc>().add(FetchProductsEvent());
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
