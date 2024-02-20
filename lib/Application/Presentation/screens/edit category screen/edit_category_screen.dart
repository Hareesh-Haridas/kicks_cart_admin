import 'dart:io';

import 'package:admin/Application/Business%20logic/category/bloc/bloc/category_bloc.dart';
import 'package:admin/Application/Presentation/screens/add%20category%20screen/add_category_screen.dart';
import 'package:admin/Application/Presentation/screens/edit%20category%20screen/appbar_widget.dart';
import 'package:admin/Application/Presentation/utils/colors.dart';
import 'package:admin/Application/Presentation/utils/constants.dart';
import 'package:admin/Data/service/category/category_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class EditCategoryScreen extends StatefulWidget {
  final String categoryName;
  dynamic categoryImage; // Note: Use File? to indicate it can be null
  final String id;

  EditCategoryScreen({
    super.key,
    required this.categoryName,
    required this.categoryImage,
    required this.id,
  });

  @override
  State<EditCategoryScreen> createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  GlobalKey<FormState> categoryKey = GlobalKey<FormState>();
  late TextEditingController editCategoryNameController;
  File? editImage;

  Future getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        editImage = File(pickedFile.path);
      });
    } else {
      print('no image selected');
    }
  }

  @override
  void initState() {
    editCategoryNameController =
        TextEditingController(text: widget.categoryName);
    // editImage = widget.categoryImage as File?;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EditCategoryAppbar(),
      body: Scaffold(
        backgroundColor: kWhite,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: categoryKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(120),
                      ),
                      child: GestureDetector(
                          onTap: () async {
                            await getImage();
                          },
                          child: editImage != null
                              ? Image.file(
                                  editImage!,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  widget.categoryImage,
                                  fit: BoxFit.cover,
                                )),
                    ),
                  ],
                ),
                kHeight10,
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Add Brand Image",
                    ),
                  ],
                ),
                kHeight20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: editCategoryNameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter Brand Name',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Brand Name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                kHeight20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kBlueGray,
                        ),
                        onPressed: () async {
                          await editCategory(
                            editCategoryNameController.text,
                            editImage!,
                            context,
                            widget.id,
                          ).whenComplete(() => context
                              .read<CategoryBloc>()
                              .add(FetchCategoriesEvent()));
                        },
                        child: const Text(
                          "Submit",
                          style: TextStyle(color: kWhite),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
