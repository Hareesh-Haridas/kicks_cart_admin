// import 'package:admin/application/Presentation/screens/add%20category%20screen/add_category_screen.dart';
import 'package:admin/application/Presentation/utils/colors.dart';
import 'package:admin/application/presentation/screens/add_category_screen/add_category_screen.dart';
import 'package:flutter/material.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blueGrey[900],
      title: const Text(
        "Brands",
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddCategoryScreen()));
            },
            icon: const Icon(
              Icons.add,
              color: kWhite,
            ))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
