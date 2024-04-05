import 'package:admin/Application/Presentation/screens/add_banner_screen/add_banner_screen.dart';
import 'package:admin/Application/Presentation/utils/colors.dart';
import 'package:flutter/material.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blueGrey[900],
      title: const Text(
        "Add Product",
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
      actions: [
        TextButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddBannerScreen()));
            },
            icon: Icon(
              Icons.add,
              color: kWhite,
            ),
            label: Text(
              'Add Banner',
              style: TextStyle(color: kWhite),
            ))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
