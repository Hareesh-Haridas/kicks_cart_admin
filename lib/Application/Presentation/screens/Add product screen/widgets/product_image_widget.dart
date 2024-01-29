import 'package:flutter/material.dart';

class ImageAddWidget extends StatelessWidget {
  const ImageAddWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 150,
          width: 200,
          decoration:
              BoxDecoration(border: Border.all(), color: Colors.grey[100]),
          child: TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text("Add image")),
        ),
      ],
    );
  }
}
