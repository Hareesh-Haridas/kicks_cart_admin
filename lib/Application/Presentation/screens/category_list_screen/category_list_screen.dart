// import 'package:admin/Application/Business%20logic/category/bloc/bloc/category_bloc.dart';
// import 'package:admin/application/Presentation/screens/category%20list%20screen/widgets/category_list_appbar_widget.dart';
// import 'package:admin/application/Presentation/screens/edit%20category%20screen/edit_category_screen.dart';
// import 'package:admin/application/Presentation/utils/colors.dart';
// import 'package:admin/application/Presentation/utils/constants.dart';

import 'package:admin/application/business_logic/category/bloc/bloc/category_bloc.dart';
import 'package:admin/application/presentation/screens/category_list_screen/widgets/category_list_appbar_widget.dart';
import 'package:admin/application/presentation/screens/edit_category_screen/edit_category_screen.dart';
import 'package:admin/application/presentation/utils/colors.dart';
import 'package:admin/application/presentation/utils/constants.dart';
import 'package:admin/data/service/category/category_functions.dart';
import 'package:admin/domain/models/add_category_model/add_category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({super.key});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

late CategoryBloc categoryBloc;

class _CategoryListScreenState extends State<CategoryListScreen> {
  @override
  void initState() {
    super.initState();
    categoryBloc = context.read<CategoryBloc>();
    categoryBloc.add(FetchCategoriesEvent());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    categoryBloc = context.read<CategoryBloc>();
    categoryBloc.add(FetchCategoriesEvent());
  }

  BrandService brandService = BrandService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: const AppbarWidget(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            kHeight20,
            BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
              if (state is LoadingCategoryState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is LoadedCategoryState) {
                List<BrandModel>? categories = state.categories;
                String blockStatus = 'Block';
                if (categories.isEmpty) {
                  return const Center(child: Text('No Categories Avaiable'));
                } else {
                  return Expanded(
                    child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: categories.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 8 / 6,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15,
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        double customHeight = 100.0;
                        double customWidth = 150.0;
                        return SizedBox(
                          height: customHeight,
                          width: customWidth,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                                color: kWhite,
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black26,
                                      spreadRadius: 1,
                                      blurRadius: 3)
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                          maxRadius: 23,
                                          backgroundImage: NetworkImage(
                                              categories[index].image)),
                                      kWidth10,
                                      Text(
                                        categories[index].name,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (_) => AlertDialog(
                                                title: const Text(
                                                    'Bloc/Unblock Brand'),
                                                content: const Text(
                                                    'Are you sure you want to Update brand status?'),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child:
                                                          const Text('Cancel')),
                                                  TextButton(
                                                    onPressed: () async {
                                                      await brandService
                                                          .changeBrandStatus(
                                                              categories[index]
                                                                  .id,
                                                              context)
                                                          .whenComplete(() {
                                                        context
                                                            .read<
                                                                CategoryBloc>()
                                                            .add(
                                                                FetchCategoriesEvent());
                                                      });
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text('Update'),
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                          child: categories[index].blocked ==
                                                  true
                                              ? const Text(
                                                  'Unblock',
                                                  style:
                                                      TextStyle(color: kGreen),
                                                )
                                              : const Text(
                                                  'Block',
                                                  style: TextStyle(color: kRed),
                                                )),
                                      IconButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditCategoryScreen(
                                                          categoryImage:
                                                              categories[index]
                                                                  .image,
                                                          categoryName:
                                                              categories[index]
                                                                  .name,
                                                          id: categories[index]
                                                              .id,
                                                        )));
                                          },
                                          icon: const Icon(
                                            Icons.edit_outlined,
                                            color: kBlue,
                                          ))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              } else if (state is ErrorCategoryState) {
                return Center(
                  child: Text('Error ${state.error}'),
                );
              } else {
                return const Center(
                  child: Text('Unknown State'),
                );
              }
            })
          ],
        ),
      ),
    );
  }
}
