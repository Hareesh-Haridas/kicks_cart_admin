import 'dart:io';

// import 'package:admin/Application/Business%20logic/category/bloc/bloc/category_bloc.dart';
// import 'package:admin/application/Presentation/screens/Add%20product%20screen/widgets/add_appbar_widget.dart';
// import 'package:admin/application/Presentation/screens/Add%20product%20screen/widgets/button_widgets.dart';
// import 'package:admin/application/Presentation/screens/Add%20product%20screen/widgets/product_image_widget.dart';
// import 'package:admin/application/Presentation/screens/Add%20product%20screen/widgets/text_form_field_widgets.dart';
// import 'package:admin/application/Presentation/utils/colors.dart';
// import 'package:admin/application/Presentation/utils/constants.dart';
import 'package:admin/application/business_logic/category/bloc/bloc/category_bloc.dart';
import 'package:admin/application/presentation/screens/add_product_screen/widgets/add_appbar_widget.dart';
import 'package:admin/application/presentation/screens/add_product_screen/widgets/button_widgets.dart';
import 'package:admin/application/presentation/screens/add_product_screen/widgets/product_image_widget.dart';
import 'package:admin/application/presentation/screens/add_product_screen/widgets/text_form_field_widgets.dart';
import 'package:admin/application/presentation/screens/add_product_screen/widgets/text_widgets.dart';
import 'package:admin/application/presentation/utils/colors.dart';
import 'package:admin/application/presentation/utils/constants.dart';
import 'package:admin/domain/models/add_category_model/add_category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPrductScreen extends StatefulWidget {
  const AddPrductScreen({super.key});

  @override
  State<AddPrductScreen> createState() => _AddPrductScreenState();
}

late Future<List<dynamic>> futureCategories;
List<String> selectedFilterChips = [];
int counter = 0;
String? valueChoose;

GlobalKey<FormState> formKey = GlobalKey<FormState>();
List<File?> selectedImages = [];
TextEditingController addStockController = TextEditingController();

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

  void clearFields() {
    setState(() {
      selectedImages.clear();
      counter = 0;
      valueChoose = null;
    });
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
                        "Choose Brand",
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                  kHeight10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 170,
                        child: AddStockTextField(),
                      ),
                      BlocBuilder<CategoryBloc, CategoryState>(
                        builder: (context, state) {
                          if (state is LoadingCategoryState) {
                            return const CircularProgressIndicator();
                          } else if (state is LoadedCategoryState) {
                            List<BrandModel> categories = state.categories;
                            if (categories.isEmpty) {
                              return const Text('No Brands available');
                            } else {
                              return DropdownButton(
                                  dropdownColor: Colors.white,
                                  style: const TextStyle(color: kWhite),
                                  hint: const Text('Choose Brand'),
                                  value: valueChoose,
                                  items: categories
                                      .map<DropdownMenuItem<String>>(
                                          (BrandModel item) {
                                    return DropdownMenuItem<String>(
                                        value: item.name,
                                        child: Text(
                                          item.name,
                                          style: const TextStyle(color: kBlack),
                                        ));
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      valueChoose = newValue;
                                    });
                                  });
                            }
                          } else {
                            return const Text("Unexpected error occured");
                          }
                        },
                      )
                    ],
                  ),
                  kHeight10,
                  AddProductButton(
                    contexts: context,
                    clearFields: clearFields,
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
