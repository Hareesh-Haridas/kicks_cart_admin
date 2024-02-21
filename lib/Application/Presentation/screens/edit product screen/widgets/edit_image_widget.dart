import 'package:flutter/material.dart';

class EditImageWidget extends StatelessWidget {
  const EditImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 150,
          width: 200,
          decoration:
              BoxDecoration(border: Border.all(), color: Colors.grey[100]),
          child: Image.asset("assets/nike_shoe_1.png"),
        ),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add),
          label: const Text("Add Image"),
        )
      ],
    );
  }
}
