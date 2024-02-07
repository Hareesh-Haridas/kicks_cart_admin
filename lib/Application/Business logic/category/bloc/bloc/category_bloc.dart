import 'package:admin/Data/service/category/category_functions.dart';


import 'package:admin/Domain/models/add%20category%20model/add_category_model.dart';


import 'package:bloc/bloc.dart';


import 'package:meta/meta.dart';


part 'category_event.dart';


part 'category_state.dart';


class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {

  CategoryBloc() : super(LoadingCategoryState()) {

    on<FetchCategoriesEvent>((event, emit) async {

      try {

        List<BrandModel> categories = await getCategories();


        emit(LoadedCategoryState(categories));

      } catch (e) {

        emit(ErrorCategoryState('Error Fetching Categories $e'));

      }

    });

  }

}

