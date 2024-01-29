import 'package:admin/Application/Presentation/screens/Edit%20screen/widgets/appBar_widget.dart';
import 'package:admin/Application/Presentation/screens/Edit%20screen/widgets/button_widgets.dart';
import 'package:admin/Application/Presentation/screens/Edit%20screen/widgets/dropdown_widget.dart';
import 'package:admin/Application/Presentation/screens/Edit%20screen/widgets/edit_image_widget.dart';
import 'package:admin/Application/Presentation/screens/Edit%20screen/widgets/filter_chip_widget.dart';
import 'package:admin/Application/Presentation/screens/Edit%20screen/widgets/text_widgets.dart';
import 'package:admin/Application/Presentation/utils/colors.dart';
import 'package:admin/Application/Presentation/utils/constants.dart';
import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kWhite,
      resizeToAvoidBottomInset: false,
      appBar: AppbarWidget(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              kHeight30,
              EditImageWidget(),
              kHeight20,
              NameField(),
              kHeight20,
              PriceField(),
              kHeight20,
              DescriptionField(),
              kHeight10,
              EditSizeText(),
              kHeight10,
              SizeSelector(),
              kHeight20,
              EditStockAndChangeCategoryText(),
              kHeight10,
              Row(
                children: [
                  DecreaseButton(),
                  Counter(),
                  IncrementButton(),
                  SizedBox(width: 120),
                  DropdownWidget(),
                ],
              ),
              kHeight10,
              SaveChangesButton(),
              kHeight10,
            ],
          ),
        ),
      ),
    );
  }
}
