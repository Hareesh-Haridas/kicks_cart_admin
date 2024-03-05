// import 'package:admin/Application/Presentation/screens/Edit%20screen/widgets/appBar_widget.dart';
import 'dart:io';

import 'package:admin/Application/Presentation/screens/edit%20product%20screen/widgets/appbar_widget.dart';
import 'package:admin/Application/Presentation/screens/edit%20product%20screen/widgets/button_widgets.dart';
import 'package:admin/Application/Presentation/screens/edit%20product%20screen/widgets/dropdown_widget.dart';
import 'package:admin/Application/Presentation/screens/edit%20product%20screen/widgets/edit_image_widget.dart';
import 'package:admin/Application/Presentation/screens/edit%20product%20screen/widgets/image_widgets.dart';
import 'package:admin/Application/Presentation/screens/edit%20product%20screen/widgets/stock_widget.dart';
import 'package:admin/Application/Presentation/screens/edit%20product%20screen/widgets/text_widgets.dart';
import 'package:admin/Application/Presentation/utils/colors.dart';
import 'package:admin/Application/Presentation/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';

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
final ImagePicker imagePicker = ImagePicker();
late String editId;
late int editStock;

class _EditProductScreenState extends State<EditProductScreen> {
  Future<void> pickImage(int index) async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        editSelectedImages[index] = File(pickedFile.path);
      });
    }
  }

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
    editSelectedImages = List.generate(4, (index) {
      if (images.isNotEmpty && images.length > index) {
        return File(images[index]);
      }
      return null;
    });
    editId = widget.id;
    editStock = widget.stock;
    print('INITIAL STOCK====${widget.stock}');
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
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Container(
              //       height: 150,
              //       width: 260,
              //       decoration: BoxDecoration(
              //         border: Border.all(color: kGrey),
              //       ),
              //       child: Image.network(images[0]),
              //     ),
              //     IconButton(
              //         onPressed: () {},
              //         icon: const Icon(
              //           Icons.edit,
              //           color: kBlue,
              //         ))
              //   ],
              // ),
              // kHeight10,
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Container(
              //       height: 150,
              //       width: 260,
              //       decoration: BoxDecoration(
              //         border: Border.all(color: kGrey),
              //       ),
              //       child: Image.network(images[1]),
              //     ),
              //     IconButton(
              //         onPressed: () {},
              //         icon: const Icon(Icons.edit, color: kBlue))
              //   ],
              // ),
              // kHeight10,
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Container(
              //       height: 150,
              //       width: 260,
              //       decoration: BoxDecoration(
              //         border: Border.all(color: kGrey),
              //       ),
              //       child: Image.network(images[2]),
              //     ),
              //     IconButton(
              //         onPressed: () {},
              //         icon: const Icon(Icons.edit, color: kBlue))
              //   ],
              // ),
              // kHeight10,
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Container(
              //       height: 150,
              //       width: 260,
              //       decoration: BoxDecoration(
              //         border: Border.all(color: kGrey),
              //       ),
              //       child: Image.network(images[3]),
              //     ),
              //     IconButton(
              //         onPressed: () {},
              //         icon: const Icon(Icons.edit, color: kBlue))
              //   ],
              // ),
              for (int i = 0; i < 4; i++)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 150,
                      width: 260,
                      decoration: BoxDecoration(
                        border: Border.all(color: kGrey),
                      ),
                      child: editSelectedImages.isNotEmpty &&
                              editSelectedImages[i]!.existsSync()
                          ? Image.file(editSelectedImages[i]!)
                          : Image.network(images[i]),
                    ),
                    IconButton(
                      onPressed: () async {
                        await pickImage(i);
                      },
                      icon: Icon(
                        Icons.edit,
                        color: kBlue,
                      ),
                    ),
                  ],
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
