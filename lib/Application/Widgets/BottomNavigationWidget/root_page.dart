import 'package:admin/Application/Business%20logic/Bottom%20Nav/bloc/bottom_navigation_bloc.dart';
import 'package:admin/Application/Presentation/screens/Add%20product%20screen/product_add_screen.dart';
import 'package:admin/Application/Presentation/screens/edit%20product%20screen/edit_screen.dart';
import 'package:admin/Application/Presentation/screens/Home/home_screen.dart';
import 'package:admin/Application/Presentation/screens/Order%20Screen/order_screen.dart';
import 'package:admin/Application/Presentation/screens/add%20category%20screen/add_category_screen.dart';
import 'package:admin/Application/Presentation/screens/category%20list%20screen/category_list_screen.dart';
import 'package:admin/Application/Widgets/BottomNavigationWidget/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
        builder: (context, state) {
          return IndexedStack(
            index: state.index,
            children: screens,
          );
        },
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }
}

List<Widget> screens = [
  const HomeScreen(),
  const AddPrductScreen(),
  const CategoryListScreen(),
  const OrderScreen()
];
