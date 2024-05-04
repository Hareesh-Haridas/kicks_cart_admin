// import 'package:admin/Application/Presentation/screens/Edit%20screen/widgets/appBar_widget.dart';
import 'dart:io';

// import 'package:admin/application/Presentation/screens/edit%20product%20screen/widgets/appar_widget.dart';
// import 'package:admin/application/Presentation/screens/edit%20product%20screen/widgets/button_widgets.dart';
// import 'package:admin/application/Presentation/screens/edit%20product%20screen/widgets/dropdown_widget.dart';
// import 'package:admin/application/Presentation/screens/edit%20product%20screen/widgets/image_picker_widget.dart';
// import 'package:admin/application/Presentation/screens/edit%20product%20screen/widgets/stock_widget.dart';
// import 'package:admin/application/Presentation/screens/edit%20product%20screen/widgets/text_widgets.dart';
import 'package:admin/application/Presentation/utils/colors.dart';
import 'package:admin/application/Presentation/utils/constants.dart';
import 'package:admin/application/presentation/screens/edit_product_screen/widgets/appar_widget.dart';
import 'package:admin/application/presentation/screens/edit_product_screen/widgets/button_widgets.dart';
import 'package:admin/application/presentation/screens/edit_product_screen/widgets/dropdown_widget.dart';
import 'package:admin/application/presentation/screens/edit_product_screen/widgets/image_picker_widget.dart';
import 'package:admin/application/presentation/screens/edit_product_screen/widgets/stock_widget.dart';
import 'package:admin/application/presentation/screens/edit_product_screen/widgets/text_widgets.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProductScreen extends StatefulWidget {
  final List<File?> editSelectedImages;
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

  EditProductScreen({
    super.key,
    required this.name,
    required this.price,
    required this.description,
    required this.stock,
    required this.category,
    required this.id,
    this.image1,
    this.image2,
    this.image3,
    this.image4,
    List<File?>? editSelectedImages,
  })  : editSelectedImages = editSelectedImages ?? [null, null, null, null],
        super();

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

List<dynamic> images = [];
final ImagePicker imagePicker = ImagePicker();
late String editId;
late int editStock;
List<File?> editSelectedImages = [];

class _EditProductScreenState extends State<EditProductScreen> {
  @override
  void initState() {
    super.initState();
    editProductNameController = TextEditingController(text: widget.name);
    editProductPriceController =
        TextEditingController(text: widget.price.toString());
    editProductDescriptionController =
        TextEditingController(text: widget.description);
    images = [];
    images.add(widget.image1);
    images.add(widget.image2);
    images.add(widget.image3);
    images.add(widget.image4);

    editId = widget.id;
    editStock = widget.stock;
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
              for (int i = 0; i < 4; i++)
                ImagePickerWidget(
                  key: UniqueKey(),
                  index: i,
                  image: widget.editSelectedImages[i],
                  imageUrl: images[i],
                  updateSelectedImage: (pickedFile, index) {
                    setState(() {
                      widget.editSelectedImages[index] = pickedFile;
                    });
                  },
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
              SaveChangesButton(
                editSelectedImages: widget.editSelectedImages,
              ),
              kHeight10,
            ],
          ),
        ),
      ),
    );
  }
}
