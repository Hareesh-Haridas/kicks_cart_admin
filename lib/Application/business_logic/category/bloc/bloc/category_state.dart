part of 'category_bloc.dart';


@immutable

sealed class CategoryState {}


final class CategoryInitial extends CategoryState {}


class LoadingCategoryState extends CategoryState {}


class LoadedCategoryState extends CategoryState {

  final List<BrandModel> categories;


  LoadedCategoryState(this.categories);

}


class ErrorCategoryState extends CategoryState {

  final String error;


  ErrorCategoryState(this.error);

}

