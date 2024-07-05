import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductDescriptionWidget extends StatefulWidget {
  const ProductDescriptionWidget({
    super.key,
  });

  @override
  State<ProductDescriptionWidget> createState() =>
      _ProductDescriptionWidgetState();
}

TextEditingController productDescriptionController = TextEditingController();

class _ProductDescriptionWidgetState extends State<ProductDescriptionWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: productDescriptionController,
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Product Description'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please Enter Product Description';
        }
        return null;
      },
    );
  }
}

class ProductPriceWidget extends StatefulWidget {
  const ProductPriceWidget({
    super.key,
  });

  @override
  State<ProductPriceWidget> createState() => _ProductPriceWidgetState();
}

TextEditingController productPriceController = TextEditingController();

class _ProductPriceWidgetState extends State<ProductPriceWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: productPriceController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Product price'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please Enter Product Price';
        }
        return null;
      },
    );
  }
}

// ignore: must_be_immutable
class ProductNameWidget extends StatefulWidget {
  const ProductNameWidget({
    super.key,
  });

  @override
  State<ProductNameWidget> createState() => _ProductNameWidgetState();
}

TextEditingController productNameController = TextEditingController();

class _ProductNameWidgetState extends State<ProductNameWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      inputFormatters: const <TextInputFormatter>[
        // FilteringTextInputFormatter.deny(RegExp(r'[!@#$%^&*(),.?":{}|<>]')),
        // FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))
      ],
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: productNameController,
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Product Name'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please Enter Product Name';
        }
        return null;
      },
    );
  }
}
