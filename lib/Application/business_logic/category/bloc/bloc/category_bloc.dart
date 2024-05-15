// import 'package:admin/Data/service/category/category_functions.dart';


import 'package:admin/data/service/category/category_functions.dart';

import 'package:admin/domain/models/add_category_model/add_category_model.dart';


import 'package:flutter/material.dart';


import 'package:flutter_bloc/flutter_bloc.dart';


// import 'package:bloc/bloc.dart';


// import 'package:meta/meta.dart';


part 'category_event.dart';


part 'category_state.dart';


class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {

  CategoryBloc() : super(LoadingCategoryState()) {

    on<FetchCategoriesEvent>((event, emit) async {

      try {

        BrandService brandService = BrandService();


        List<BrandModel> categories = await brandService.getCategories();


        emit(LoadedCategoryState(categories));

      } catch (e) {

        emit(ErrorCategoryState('Error Fetching Categories $e'));

      }

    });

  }

}

