import 'dart:io';

import 'package:admin/Application/Presentation/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageAddWidget extends StatefulWidget {
  final List<File?> imageList;
  final Function(List<File?>) onImageAdded;
  const ImageAddWidget({
    super.key,
    required this.imageList,
    required this.onImageAdded,
  });

  @override
  State<ImageAddWidget> createState() => _ImageAddWidgetState();
}

class _ImageAddWidgetState extends State<ImageAddWidget> {
  File? productImage;
  Future getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        productImage = File(pickedFile.path);
        widget.imageList.add(File(pickedFile.path));
        widget.onImageAdded(widget.imageList);
      });
    } else {
      print('No Image Selected');
    }
  }

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
            child: productImage != null
                ? Image.file(
                    productImage!,
                    fit: BoxFit.cover,
                  )
                : IconButton(
                    onPressed: () async {
                      await getImage();
                    },
                    icon: const Icon(Icons.add_a_photo_outlined))),
      ],
    );
  }
}
