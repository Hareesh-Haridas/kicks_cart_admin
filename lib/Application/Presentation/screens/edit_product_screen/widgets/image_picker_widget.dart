// import 'dart:io';

// import 'package:admin/Application/Presentation/utils/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class ImagePickerWidget extends StatefulWidget {
//   final File? image;
//   final String imageUrl;
//   final Function(File?) pickImage;
//   const ImagePickerWidget(
//       {super.key,
//       required this.image,
//       required this.imageUrl,
//       required this.pickImage});

//   @override
//   State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
// }

// class _ImagePickerWidgetState extends State<ImagePickerWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Container(
//             height: 150,
//             width: 260,
//             decoration: BoxDecoration(
//               border: Border.all(color: kGrey),
//             ),
//             child: widget.image != null
//                 ? Image.file(widget.image!)
//                 : Image.network(widget.imageUrl)),
//         IconButton(
//             onPressed: () async {
//               final pickedFile =
//                   await ImagePicker().pickImage(source: ImageSource.gallery);
//               if (pickedFile != null) {
//                 widget.pickImage(File(pickedFile.path));
//               }
//             },
//             icon: const Icon(
//               Icons.edit,
//               color: kBlue,
//             ))
//       ],
//     );
//   }
// }
import 'dart:io';

import 'package:admin/application/Presentation/utils/colors.dart';
import 'package:admin/application/presentation/screens/add_product_screen/product_add_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  final File? image;
  final String imageUrl;
  final Function(File? pickedFile, int index) updateSelectedImage;
  final int index;

  const ImagePickerWidget({
    super.key,
    required this.image,
    required this.imageUrl,
    required this.updateSelectedImage,
    required this.index,
  });

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _selectedImage = widget.image;
  }

  void deleteImage() {
    setState(() {
      _selectedImage = null;
    });
    widget.updateSelectedImage(null, widget.index);
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
          child: _selectedImage != null
              ? Image.file(_selectedImage!)
              : (widget.imageUrl.isNotEmpty)
                  ? Image.network(widget.imageUrl)
                  : (widget.image != null)
                      ? Image.file(widget.image!)
                      : const Placeholder(),
        ),
        _selectedImage != null
            ? IconButton(
                onPressed: () {
                  deleteImage();
                },
                icon: const Icon(
                  Icons.delete,
                  color: kRed,
                ))
            : IconButton(
                onPressed: () async {
                  final pickedFile = await ImagePicker().pickImage(
                    source: ImageSource.gallery,
                  );
                  if (pickedFile != null) {
                    setState(() {
                      _selectedImage = File(pickedFile.path);
                    });
                    widget.updateSelectedImage(_selectedImage, widget.index);
                  }
                },
                icon: const Icon(
                  Icons.edit,
                  color: kBlue,
                ),
              ),
      ],
    );
  }
}
