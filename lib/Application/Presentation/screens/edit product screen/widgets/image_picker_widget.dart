import 'dart:io';

import 'package:admin/Application/Presentation/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  final File? image;
  final String imageUrl;
  final Function(File?) pickImage;
  const ImagePickerWidget(
      {super.key,
      required this.image,
      required this.imageUrl,
      required this.pickImage});

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            height: 150,
            width: 260,
            decoration: BoxDecoration(
              border: Border.all(color: kGrey),
            ),
            child: widget.image != null
                ? Image.file(widget.image!)
                : Image.network(widget.imageUrl)),
        IconButton(
            onPressed: () async {
              final pickedFile =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              if (pickedFile != null) {
                widget.pickImage(File(pickedFile.path));
              }
            },
            icon: Icon(
              Icons.edit,
              color: kBlue,
            ))
      ],
    );
  }
}
