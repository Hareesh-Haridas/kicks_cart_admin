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
          "Change Brand",
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

class DescriptionField extends StatefulWidget {
  const DescriptionField({
    super.key,
  });

  @override
  State<DescriptionField> createState() => _DescriptionFieldState();
}

late TextEditingController editProductDescriptionController;

class _DescriptionFieldState extends State<DescriptionField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: editProductDescriptionController,
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Enter Product Description'),
    );
  }
}

class PriceField extends StatefulWidget {
  const PriceField({
    super.key,
  });

  @override
  State<PriceField> createState() => _PriceFieldState();
}

late TextEditingController editProductPriceController;

class _PriceFieldState extends State<PriceField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: editProductPriceController,
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Enter Product Price'),
    );
  }
}

class NameField extends StatefulWidget {
  const NameField({
    super.key,
  });

  @override
  State<NameField> createState() => _NameFieldState();
}

late TextEditingController editProductNameController;

class _NameFieldState extends State<NameField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: editProductNameController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Enter Product Name',
      ),
    );
  }
}
