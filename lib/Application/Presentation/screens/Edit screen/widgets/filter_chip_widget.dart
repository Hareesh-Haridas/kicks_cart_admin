import 'package:admin/Application/Presentation/utils/constants.dart';
import 'package:flutter/material.dart';

class SizeSelector extends StatefulWidget {
  const SizeSelector({super.key});

  @override
  State<SizeSelector> createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  bool eSmallSelected = true;
  bool eMediumSelected = false;
  bool eLargeSelected = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FilterChip(
          selectedColor: Colors.orange[900],
          label: const Text(
            'Small',
          ),
          selected: !eSmallSelected,
          onSelected: (bool value) {
            setState(() {
              eSmallSelected = !eSmallSelected;
            });
          },
        ),
        kWidth10,
        FilterChip(
          selectedColor: Colors.orange[900],
          label: const Text(
            'Medium',
          ),
          selected: eMediumSelected,
          onSelected: (bool value) {
            setState(() {
              eMediumSelected = !eMediumSelected;
            });
          },
        ),
        kWidth10,
        FilterChip(
          selectedColor: Colors.orange[900],
          label: const Text(
            'Large',
          ),
          selected: eLargeSelected,
          onSelected: (bool value) {
            setState(() {
              eLargeSelected = !eLargeSelected;
            });
          },
        ),
      ],
    );
  }
}
