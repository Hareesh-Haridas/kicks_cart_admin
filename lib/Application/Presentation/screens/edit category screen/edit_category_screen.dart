import 'dart:io';

import 'package:admin/Application/Presentation/screens/edit%20category%20screen/appbar_widget.dart';
import 'package:admin/Application/Presentation/utils/colors.dart';
import 'package:admin/Application/Presentation/utils/constants.dart';
import 'package:flutter/material.dart';

class EditCategoryScreen extends StatefulWidget {
  const EditCategoryScreen({
    super.key,
  });

  @override
  State<EditCategoryScreen> createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  GlobalKey<FormState> categoryKey = GlobalKey<FormState>();
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
                          borderRadius: BorderRadius.circular(120)),
                      child: const ClipOval(
                        child: Icon(Icons.camera),
                      ),
                    )
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
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: kBlueGray),
                          onPressed: () {},
                          child: const Text("Submit")),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
