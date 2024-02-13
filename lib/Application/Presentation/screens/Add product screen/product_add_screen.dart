import 'dart:io';

import 'package:admin/Application/Presentation/screens/Add%20product%20screen/widgets/add_appbar_widget.dart';
import 'package:admin/Application/Presentation/screens/Add%20product%20screen/widgets/button_widgets.dart';
import 'package:admin/Application/Presentation/screens/Add%20product%20screen/widgets/product_image_widget.dart';
import 'package:admin/Application/Presentation/screens/Add%20product%20screen/widgets/text_form_field_widgets.dart';
import 'package:admin/Application/Presentation/screens/Add%20product%20screen/widgets/text_widgets.dart';
import 'package:admin/Application/Presentation/utils/colors.dart';
import 'package:admin/Application/Presentation/utils/constants.dart';
import 'package:admin/Data/service/category/category_functions.dart';
import 'package:admin/Domain/models/add%20category%20model/add_category_model.dart';
import 'package:flutter/material.dart';

class AddPrductScreen extends StatefulWidget {
  const AddPrductScreen({super.key});

  @override
  State<AddPrductScreen> createState() => _AddPrductScreenState();
}

late Future<List<dynamic>> futureCategories;
List<String> selectedFilterChips = [];
int counter = 0;
String? valueChoose;
//List listItem = ["Sports", "Casual", "Formal", "Boots"];
bool smallSelected = false;
bool mediumSelected = false;
bool largeSelected = false;
List<File?> selectedImages = [];
GlobalKey<FormState> formKey = GlobalKey<FormState>();

class _AddPrductScreenState extends State<AddPrductScreen> {
  void increment() {
    setState(() {
      counter++;
    });
  }

  void decrement() {
    setState(() {
      if (counter > 0) {
        counter--;
      } else {
        counter = 0;
      }
    });
  }

  void updateSelectedFilterChips(String chipText, bool isSelected) {
    setState(() {
      if (isSelected) {
        selectedFilterChips.add(chipText);
      } else {
        selectedFilterChips.remove(chipText);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    futureCategories = getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kWhite,
      appBar: const AppbarWidget(),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  kHeight30,
                  ImageAddWidget(
                    imageList: selectedImages,
                    onImageAdded: (List<File?> updatedImages) {
                      setState(() {
                        selectedImages = updatedImages;
                      });
                    },
                  ),
                  kHeight20,
                  ImageAddWidget(
                    imageList: selectedImages,
                    onImageAdded: (List<File?> updatedImages) {
                      setState(() {
                        selectedImages = updatedImages;
                      });
                    },
                  ),
                  kHeight20,
                  ImageAddWidget(
                    imageList: selectedImages,
                    onImageAdded: (List<File?> updatedImages) {
                      setState(() {
                        selectedImages = updatedImages;
                      });
                    },
                  ),
                  kHeight20,
                  ImageAddWidget(
                    imageList: selectedImages,
                    onImageAdded: (List<File?> updatedImages) {
                      setState(() {
                        selectedImages = updatedImages;
                      });
                    },
                  ),
                  kHeight20,
                  const ProductNameWidget(),
                  kHeight20,
                  const ProductPriceWidget(),
                  kHeight20,
                  const ProductDescriptionWidget(),
                  kHeight10,
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Add Stock",
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        "Choose Category",
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                  kHeight10,
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            border: Border.all(), color: Colors.blueGrey[900]),
                        child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              decrement();
                            },
                            icon: const Icon(
                              Icons.minimize,
                              color: kWhite,
                            )),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 30,
                        width: 40,
                        decoration: BoxDecoration(border: Border.all()),
                        child: Text(
                          "$counter",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            border: Border.all(), color: Colors.blueGrey[900]),
                        child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              increment();
                            },
                            icon: const Icon(
                              Icons.add,
                              color: kWhite,
                            )),
                      ),
                      const SizedBox(width: 90),
                      FutureBuilder<List<dynamic>>(
                        future: futureCategories,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error ${snapshot.error}');
                          } else {
                            List<dynamic> listItem = snapshot.data!;
                            return DropdownButton(
                              dropdownColor: kWhite,
                              style: const TextStyle(color: kWhite),
                              hint: const Text("Choose Category"),
                              value: valueChoose,
                              items: listItem.map<DropdownMenuItem<String>>(
                                  (dynamic item) {
                                return DropdownMenuItem<String>(
                                  value: item.name,
                                  child: Text(
                                    item.name,
                                    style: const TextStyle(color: kBlack),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  valueChoose = newValue as String?;
                                });
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                  kHeight10,
                  AddProductButton(
                    contexts: context,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
