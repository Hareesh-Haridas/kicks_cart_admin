import 'package:flutter/material.dart';

class EditStockAndChangeCategoryText extends StatelessWidget {
  const EditStockAndChangeCategoryText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Edit Stock",
          style: TextStyle(fontSize: 20),
        ),
        Text(
          "Change Category",
          style: TextStyle(fontSize: 20),
        )
      ],
    );
  }
}

class EditSizeText extends StatelessWidget {
  const EditSizeText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Text(
          "Edit Size",
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}

class DescriptionField extends StatelessWidget {
  const DescriptionField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Nike sports shoe for everyday use'),
    );
  }
}

class PriceField extends StatelessWidget {
  const PriceField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
          border: OutlineInputBorder(), hintText: 'Rs.5000'),
    );
  }
}

class NameField extends StatelessWidget {
  const NameField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
          border: OutlineInputBorder(), hintText: 'Nike Sports Shoe'),
    );
  }
}
