import 'package:admin/Application/Presentation/utils/colors.dart';
import 'package:flutter/material.dart';

class DropdownWidget extends StatefulWidget {
  const DropdownWidget({super.key});

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  String? select;
  List<String> categories = ['Sports', 'Formal', 'Casual', 'Boots'];
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      dropdownColor: kWhite,
      style: const TextStyle(color: kWhite),
      hint: const Text("Casual"),
      value: select,
      items: categories.map((valueItem) {
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
          select = newValue;
        });
      },
    );
  }
}
