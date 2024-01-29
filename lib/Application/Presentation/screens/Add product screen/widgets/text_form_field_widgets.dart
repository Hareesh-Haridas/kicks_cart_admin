import 'package:flutter/material.dart';

class ProductDescriptionWidget extends StatelessWidget {
  const ProductDescriptionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Product Description'),
    );
  }
}

class ProductPriceWidget extends StatelessWidget {
  const ProductPriceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Product price'),
    );
  }
}

class ProductNameWidget extends StatelessWidget {
  const ProductNameWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Product Name'),
    );
  }
}
