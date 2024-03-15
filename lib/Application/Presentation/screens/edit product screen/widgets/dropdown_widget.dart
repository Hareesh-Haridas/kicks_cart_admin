import 'package:admin/Application/Business%20logic/category/bloc/bloc/category_bloc.dart';
import 'package:admin/Application/Presentation/screens/Add%20product%20screen/product_add_screen.dart';
import 'package:admin/Application/Presentation/utils/colors.dart';
import 'package:admin/Domain/models/add%20category%20model/add_category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DropdownWidget extends StatefulWidget {
  final String? initialValue;
  const DropdownWidget({super.key, this.initialValue});

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

String? editvaluechoose;

class _DropdownWidgetState extends State<DropdownWidget> {
  @override
  void initState() {
    super.initState();
    editvaluechoose = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is LoadingCategoryState) {
          return const CircularProgressIndicator();
        } else if (state is LoadedCategoryState) {
          List<BrandModel> categories = state.categories;
          if (categories.isEmpty) {
            return const Text('No Brands available');
          } else {
            return DropdownButton(
                dropdownColor: Colors.white,
                style: const TextStyle(color: kWhite),
                hint: const Text('Choose Brand'),
                value: editvaluechoose,
                items:
                    categories.map<DropdownMenuItem<String>>((BrandModel item) {
                  return DropdownMenuItem<String>(
                      value: item.name,
                      child: Text(
                        item.name,
                        style: const TextStyle(color: kBlack),
                      ));
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    editvaluechoose = newValue as String?;
                  });
                });
          }
        } else {
          return const Text("Unexpected error occured");
        }
      },
    );
  }
}
