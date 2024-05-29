import 'dart:io';
import 'package:admin/application/business_logic/category/bloc/bloc/category_bloc.dart';
import 'package:admin/data/service/category/category_functions.dart';
import 'package:flutter/services.dart';
// import 'package:admin/Data/service/category/category_functions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:admin/application/Presentation/screens/add_category_screen/widgets/category_appbar_widget.dart';
import 'package:admin/application/Presentation/utils/colors.dart';
import 'package:admin/application/Presentation/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

TextEditingController brandNameController = TextEditingController();
File? image;
bool showSpinner = false;
String? authToken = "";
bool loading = false;

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  GlobalKey<FormState> brandKey = GlobalKey<FormState>();
  Future getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    } else {}
  }

  @override
  void dispose() {
    brandNameController.clear();
    image = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
          backgroundColor: kWhite,
          appBar: const AppbarWidget(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: brandKey,
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
                            borderRadius: BorderRadius.circular(120)),
                        child: ClipOval(
                          child: image != null
                              ? Image.file(
                                  image!,
                                  fit: BoxFit.cover,
                                )
                              : IconButton(
                                  onPressed: () async {
                                    await getImage();
                                  },
                                  icon: const Icon(Icons.add_a_photo_outlined)),
                        ),
                      ),
                    ],
                  ),
                  kHeight10,
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Add Brand Image",
                      )
                    ],
                  ),
                  kHeight20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextFormField(
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.deny(
                                RegExp(r'[!@#$%^&*(),.?":{}|<>]')),
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[a-zA-Z]'))
                          ],
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: brandNameController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter Brand Name'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Brand Name';
                            }
                            return null;
                          },
                        ),
                      )
                    ],
                  ),
                  kHeight20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      loading
                          ? const CircularProgressIndicator()
                          : Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (brandKey.currentState!.validate()) {
                                    if (image == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text(
                                          'Add Image',
                                          style: TextStyle(color: kWhite),
                                        ),
                                        backgroundColor: kRed,
                                      ));
                                    } else {
                                      setState(() {
                                        loading = true;
                                      });
                                      BrandService brandService =
                                          BrandService();
                                      await brandService
                                          .addBrand(brandNameController.text,
                                              image!, authToken!, context)
                                          .whenComplete(() {
                                        setState(() {
                                          loading = false;
                                        });

                                        context
                                            .read<CategoryBloc>()
                                            .add(FetchCategoriesEvent());
                                      });
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: kBlueGray),
                                child: const Text(
                                  'Submit',
                                  style: TextStyle(color: kWhite, fontSize: 18),
                                ),
                              ),
                            )
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
