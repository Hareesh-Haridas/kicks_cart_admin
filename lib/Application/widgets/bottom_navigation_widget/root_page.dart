import 'package:admin/application/business_logic/bottom_nav/bloc/bottom_navigation_bloc.dart';
import 'package:admin/application/presentation/screens/add_product_screen/product_add_screen.dart';
import 'package:admin/application/presentation/screens/category_list_screen/category_list_screen.dart';
import 'package:admin/application/presentation/screens/home/home_screen.dart';
import 'package:admin/application/presentation/screens/order_screen/order_screen.dart';
import 'package:admin/application/widgets/bottom_navigation_widget/bottom_navigation.dart';
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
