import 'package:admin/Application/Presentation/screens/Add%20product%20screen/widgets/add_appbar_widget.dart';
import 'package:admin/Application/Presentation/screens/Add%20product%20screen/widgets/button_widgets.dart';
import 'package:admin/Application/Presentation/screens/Add%20product%20screen/widgets/product_image_widget.dart';
import 'package:admin/Application/Presentation/screens/Add%20product%20screen/widgets/text_form_field_widgets.dart';
import 'package:admin/Application/Presentation/screens/Add%20product%20screen/widgets/text_widgets.dart';
import 'package:admin/Application/Presentation/utils/colors.dart';
import 'package:admin/Application/Presentation/utils/constants.dart';
import 'package:flutter/material.dart';

class AddPrductScreen extends StatefulWidget {
  const AddPrductScreen({super.key});

  @override
  State<AddPrductScreen> createState() => _AddPrductScreenState();
}

int counter = 0;
String? valueChoose;
List listItem = ["Sports", "Casual", "Formal", "Boots"];
bool smallSelected = false;
bool mediumSelected = false;
bool largeSelected = false;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kWhite,
      appBar: const AppbarWidget(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                kHeight30,
                const ImageAddWidget(),
                kHeight20,
                const ProductNameWidget(),
                kHeight20,
                const ProductPriceWidget(),
                kHeight20,
                const ProductDescriptionWidget(),
                kHeight10,
                const SizeAvailableText(),
                kHeight10,
                Row(
                  children: [
                    FilterChip(
                      selectedColor: Colors.orange[900],
                      label: const Text(
                        'Small',
                      ),
                      selected: smallSelected,
                      onSelected: (bool value) {
                        setState(() {
                          smallSelected = !smallSelected;
                        });
                      },
                    ),
                    kWidth10,
                    FilterChip(
                        selectedColor: Colors.orange[900],
                        label: const Text(
                          'Medium',
                        ),
                        selected: mediumSelected,
                        onSelected: (bool value) {
                          setState(() {
                            mediumSelected = !mediumSelected;
                          });
                        }),
                    kWidth10,
                    FilterChip(
                      selectedColor: Colors.orange[900],
                      label: const Text(
                        'Large',
                      ),
                      selected: largeSelected,
                      onSelected: (bool value) {
                        setState(() {
                          largeSelected = !largeSelected;
                        });
                      },
                    ),
                  ],
                ),
                kHeight20,
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
                    DropdownButton(
                      dropdownColor: kWhite,
                      style: const TextStyle(color: kWhite),
                      hint: const Text("Choose Category"),
                      value: valueChoose,
                      items: listItem.map((valueItem) {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text(
                            valueItem,
                            style: const TextStyle(color: kBlack),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          valueChoose = newValue as String?;
                        });
                      },
                    ),
                  ],
                ),
                kHeight10,
                const AddProductButton()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
