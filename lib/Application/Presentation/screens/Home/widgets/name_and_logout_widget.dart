import 'package:admin/Application/Presentation/screens/Home/widgets/kicks_kart_text_widget.dart';
import 'package:admin/Data/service/auth/autherization_functions.dart';
import 'package:flutter/material.dart';

class NameAndLogoutButton extends StatelessWidget {
  const NameAndLogoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const KicksCartText(),
        const SizedBox(
          width: 150,
        ),
        IconButton(
            onPressed: () {
              logOut(context);
            },
            icon: const Icon(Icons.logout)),
      ],
    );
  }
}
