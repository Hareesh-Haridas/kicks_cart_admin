import 'package:admin/Application/Business%20logic/product/bloc/bloc/product_bloc.dart';
import 'package:admin/Application/Presentation/screens/Add%20product%20screen/product_add_screen.dart';
import 'package:admin/Application/Presentation/screens/Add%20product%20screen/widgets/text_form_field_widgets.dart';
import 'package:admin/Application/Presentation/screens/add%20category%20screen/add_category_screen.dart';
import 'package:admin/Application/Presentation/utils/colors.dart';
import 'package:admin/Data/service/product/product_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductButton extends StatelessWidget {
  final BuildContext contexts;
  const AddProductButton({super.key, required this.contexts});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: MaterialButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                await addProduct(
                        selectedImages,
                        productNameController.text,
                        int.parse(productPriceController.text),
                        productDescriptionController.text,
                        counter,
                        valueChoose!,
                        authToken!,
                        "",
                        contexts)
                    .whenComplete(() =>
                        context.read<ProductBloc>().add(FetchProductsEvent()));
              }
            },
            color: kBlueGray,
            textColor: kWhite,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            height: 50,
            child: const Text(
              "Add this Product",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
