import 'dart:io';

import 'package:admin/application/Presentation/utils/colors.dart';
import 'package:admin/Data/service/auth/autherization_functions.dart';
import 'package:admin/Data/service/category/config.dart';
import 'package:admin/application/presentation/screens/category_list_screen/category_list_screen.dart';
import 'package:admin/domain/models/add_category_model/add_category_model.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class BrandService {
  Future<BrandModel> addBrand(
      String name, File image, String authToken, BuildContext context) async {
    BrandModel brand = BrandModel(name: "", image: "", id: "");
    try {
      FormData formData = FormData.fromMap({
        "name": name,
        "image": await MultipartFile.fromFile(image.path, filename: "image.jpg")
      });

      final response = await Dio().post(addCategoryUrl,
          data: formData,
          options: Options(headers: {'Authorization': 'Bearer $globalToken'}));
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (context.mounted) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const CategoryListScreen()));
          Navigator.of(context).pop();

          showSnackBar(context, 'Category Added');
        }

        return BrandModel.fromJson(response.data);
      } else {
        return brand;
      }
    } catch (e) {
      return brand;
    }
  }

  Future<List<BrandModel>> getCategories() async {
    try {
      final response = await Dio().get(getCategoryUrl,
          options: Options(headers: {'Authorization': 'Bearer $globalToken'}));

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<BrandModel> categories = (response.data['data'] as List)
            .map((json) => BrandModel.fromJson(json))
            .toList();
        return categories;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  String deleteResponseMessage = "";
  Future<void> deleteCategory(String id, BuildContext context) async {
    try {
      final response = await Dio().delete('$deleteCategoryUrl/$id',
          options: Options(headers: {'Authorization': 'Bearer $globalToken'}));

      deleteResponseMessage = response.data['message'];
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (context.mounted) {
          showSnackBar(context, deleteResponseMessage);
        }
      }
    } catch (e) {
      debugPrint('error deleting catgory $e');
    }
  }

  String editResponseMessage = '';
  Future<BrandModel> editCategory(
      String name, File image, BuildContext context, String id) async {
    BrandModel brandModel = BrandModel(name: "", image: "", id: "");
    FormData formData = FormData.fromMap({
      "name": name,
      "image": await MultipartFile.fromFile(image.path, filename: "image.jpg"),
      "id": id
    });
    try {
      final response = await Dio().post(editCategoryUrl,
          data: formData,
          options: Options(headers: {'Authorization': 'Bearer $globalToken'}));
      editResponseMessage = response.data['message'];
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (context.mounted) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const CategoryListScreen()));
          Navigator.of(context).pop();
          showSnackBar(context, editResponseMessage);
        }

        return BrandModel.fromJson(response.data);
      } else {
        return brandModel;
      }
    } catch (e) {
      return brandModel;
    }
  }
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: const TextStyle(color: kWhite),
    ),
    backgroundColor: Colors.green,
  ));
}
