import 'package:admin/application/Presentation/utils/colors.dart';
import 'package:flutter/material.dart';

class EditCategoryAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const EditCategoryAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: kWhite,
          )),
      backgroundColor: Colors.blueGrey[900],
      title: const Text(
        "Edit Category",
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
