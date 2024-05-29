import 'package:admin/application/presentation/screens/add_product_screen/product_add_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SizeAvailableText extends StatelessWidget {
  const SizeAvailableText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Text(
          "Size Availbale",
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}

class AddStockTextField extends StatelessWidget {
  const AddStockTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.number,
      controller: addStockController,
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Enter Product Stock'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter Stock';
        }
        return null;
      },
    );
  }
}
