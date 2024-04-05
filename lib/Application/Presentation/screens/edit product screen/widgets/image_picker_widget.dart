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

import 'package:admin/Application/Presentation/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  final File? image;
  final String imageUrl;
  final Function(File? selectedImage, File? initialImage) uploadImage;

  const ImagePickerWidget({
    Key? key,
    required this.image,
    required this.imageUrl,
    required this.uploadImage,
    required Null Function(dynamic pickedFile) pickImage,
  }) : super(key: key);

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? _selectedImage;

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
              : widget.image != null
                  ? Image.file(widget.image!)
                  : Image.network(widget.imageUrl),
        ),
        IconButton(
          onPressed: () async {
            final pickedFile = await ImagePicker().pickImage(
              source: ImageSource.gallery,
            );
            if (pickedFile != null) {
              setState(() {
                _selectedImage = File(pickedFile.path);
              });
            }
          },
          icon: const Icon(
            Icons.edit,
            color: kBlue,
          ),
        ),
        // IconButton(
        //   onPressed: () {
        //     if (_selectedImage != null || widget.image != null) {
        //       widget.uploadImage(_selectedImage, widget.image);
        //     }
        //   },
        //   icon: const Icon(
        //     Icons.upload,
        //     color: kBlue,
        //   ),
        // ),
      ],
    );
  }
}
