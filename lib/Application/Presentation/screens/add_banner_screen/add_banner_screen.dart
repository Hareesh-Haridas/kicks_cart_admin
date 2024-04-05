import 'package:admin/Application/Presentation/utils/colors.dart';
import 'package:admin/Application/Presentation/utils/constants.dart';
import 'package:flutter/material.dart';

class AddBannerScreen extends StatefulWidget {
  const AddBannerScreen({super.key});

  @override
  State<AddBannerScreen> createState() => _AddBannerScreenState();
}

class _AddBannerScreenState extends State<AddBannerScreen> {
  GlobalKey<FormState> bannerKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Form(
              key: bannerKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.arrow_back)),
                      kWidth10,
                      const Text(
                        'Add Banner Data',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.edit))
                    ],
                  ),
                  kHeight30,
                  Container(
                    height: 200,
                    width: 400,
                    decoration: BoxDecoration(border: Border.all()),
                    child: Center(
                      child: TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.add),
                          label: const Text('Image1')),
                    ),
                  ),
                  kHeight10,
                  Container(
                    height: 200,
                    width: 400,
                    decoration: BoxDecoration(border: Border.all()),
                    child: Center(
                      child: TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.add),
                          label: const Text('Image2')),
                    ),
                  ),
                  kHeight10,
                  Container(
                    height: 200,
                    width: 400,
                    decoration: BoxDecoration(border: Border.all()),
                    child: Center(
                      child: TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.add),
                          label: const Text('Image3')),
                    ),
                  ),
                  kHeight10,
                  TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Title 1'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter a Title';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  kHeight10,
                  TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Title 2'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter a Title';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  kHeight10,
                  TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Title 3'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter a Title';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  kHeight10,
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: MaterialButton(
                            onPressed: () {},
                            color: kBlueGray,
                            textColor: kWhite,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            height: 50,
                            child: const Text(
                              "Add Banner",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
