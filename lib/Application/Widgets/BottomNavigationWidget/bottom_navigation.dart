import 'package:admin/Application/Business%20logic/Bottom%20Nav/bloc/bottom_navigation_bloc.dart';
import 'package:admin/Application/Presentation/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey[900],
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 20,
        ),
        child: GNav(
          onTabChange: (value) {
            context
                .read<BottomNavigationBloc>()
                .add(IndexChangerEvent(index: value));
          },
          activeColor: kWhite,
          tabBackgroundColor: Colors.amber,
          gap: 8,
          padding: const EdgeInsets.all(11),
          tabs: const [
            GButton(
              icon: Icons.home_outlined,
              text: 'Home',
              iconColor: kWhite,
            ),
            GButton(
              icon: Icons.add,
              text: 'Add Product',
              iconColor: kWhite,
            ),
            GButton(
              icon: Icons.edit,
              text: 'Edit',
              iconColor: kWhite,
            ),
            GButton(
              icon: Icons.shopping_cart_outlined,
              text: 'Orders',
              iconColor: kWhite,
            )
          ],
        ),
      ),
    );
  }
}
