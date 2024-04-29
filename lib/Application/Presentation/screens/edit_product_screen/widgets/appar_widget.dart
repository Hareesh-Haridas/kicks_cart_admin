import 'package:flutter/material.dart';

class EditAppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const EditAppbarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blueGrey[900],
      title: const Text(
        "Edit Product",
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
