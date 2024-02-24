// import 'package:admin/Application/Presentation/screens/Edit%20screen/widgets/appBar_widget.dart';
import 'dart:io';

import 'package:admin/Application/Presentation/screens/edit%20product%20screen/widgets/appbar_widget.dart';
import 'package:admin/Application/Presentation/screens/edit%20product%20screen/widgets/button_widgets.dart';
import 'package:admin/Application/Presentation/screens/edit%20product%20screen/widgets/dropdown_widget.dart';
import 'package:admin/Application/Presentation/screens/edit%20product%20screen/widgets/edit_image_widget.dart';
import 'package:admin/Application/Presentation/screens/edit%20product%20screen/widgets/filter_chip_widget.dart';
import 'package:admin/Application/Presentation/screens/edit%20product%20screen/widgets/image_widgets.dart';
import 'package:admin/Application/Presentation/screens/edit%20product%20screen/widgets/stock_widget.dart';
import 'package:admin/Application/Presentation/screens/edit%20product%20screen/widgets/text_widgets.dart';
import 'package:admin/Application/Presentation/utils/colors.dart';
import 'package:admin/Application/Presentation/utils/constants.dart';
import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  final dynamic image1;
  final dynamic image2;
  final dynamic image3;
  final dynamic image4;
  final String name;
  final int price;
  final String description;
  final int stock;
  final String category;
  final String id;
  const EditProductScreen(
      {super.key,
      required this.name,
      required this.price,
      required this.description,
      required this.stock,
      required this.category,
      required this.id,
      this.image1,
      this.image2,
      this.image3,
      this.image4});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

List<File?> editSelectedImages = [];
List<dynamic> images = [];

class _EditProductScreenState extends State<EditProductScreen> {
  @override
  void initState() {
    super.initState();
    editProductNameController = TextEditingController(text: widget.name);
    editProductPriceController =
        TextEditingController(text: widget.price.toString());
    editProductDescriptionController =
        TextEditingController(text: widget.description);
    images.add(widget.image1);
    images.add(widget.image2);
    images.add(widget.image3);
    images.add(widget.image4);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      resizeToAvoidBottomInset: false,
      appBar: const EditAppbarWidget(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              kHeight30,
              Container(
                height: 150,
                width: 260,
                decoration: BoxDecoration(
                  border: Border.all(color: kGrey),
                ),
                child: Image.network(images[0]),
              ),
              kHeight10,
              Container(
                height: 150,
                width: 260,
                decoration: BoxDecoration(
                  border: Border.all(color: kGrey),
                ),
                child: Image.network(images[1]),
              ),
              kHeight10,
              Container(
                height: 150,
                width: 260,
                decoration: BoxDecoration(
                  border: Border.all(color: kGrey),
                ),
                child: Image.network(images[2]),
              ),
              kHeight10,
              Container(
                height: 150,
                width: 260,
                decoration: BoxDecoration(
                  border: Border.all(color: kGrey),
                ),
                child: Image.network(images[3]),
              ),
              kHeight20,
              const NameField(),
              kHeight20,
              const PriceField(),
              kHeight20,
              const DescriptionField(),
              kHeight10,
              kHeight20,
              const EditStockAndChangeCategoryText(),
              kHeight10,
              Row(
                children: [
                  CounterContainer(
                    intitialCounter: widget.stock,
                  ),
                  const SizedBox(width: 120),
                  DropdownWidget(initialValue: widget.category),
                ],
              ),
              kHeight10,
              const SaveChangesButton(),
              kHeight10,
            ],
          ),
        ),
      ),
    );
  }
}
