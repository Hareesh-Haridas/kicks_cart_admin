import 'dart:convert';
import 'dart:io';

import 'package:admin/Application/Presentation/utils/colors.dart';
import 'package:admin/Data/service/auth/autherization_functions.dart';
import 'package:admin/Data/service/category/category_functions.dart';
import 'package:admin/Data/service/product/config.dart';
import 'package:admin/Domain/models/product/edit%20product%20model/edit_product.dart';
import 'package:admin/Domain/models/product/get%20product%20model/get_product_model.dart';
import 'package:admin/Domain/models/product/add%20product%20model/product_model.dart';
//import 'package:http/http.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

Future<ProductModel> addProduct(
    List<File?> image,
    String name,
    int price,
    String description,
    int stock,
    String category,
    String authtoken,
    String message,
    BuildContext context) async {
  ProductModel productModel = ProductModel(
      productImage: image,
      productName: "",
      productPrice: 0,
      productDescription: "",
      stock: 0,
      category: "",
      message: "");
  try {
    List<MultipartFile?> imageFiles = image.map((image) {
      if (image != null) {
        return MultipartFile.fromFileSync(image.path,
            filename: image.path.split('/').last);
      } else {
        return null;
      }
    }).toList();
    FormData formData = FormData.fromMap({
      "image": imageFiles,
      "name": name,
      "price": price,
      "description": description,
      "stock": stock,
      "category": category
    });
    final response = await Dio().post(addProductUrl,
        data: formData,
        options: Options(headers: {'Authorization': 'Bearer $authtoken'}));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('response is oky');
      print('Response -------message: ${response.data['message']}');
      String responseMessage = response.data['message'] ?? "";
      print("===================${response.data['message']}");
      productShowSnackBar(context, responseMessage);
      return ProductModel.fromJson(response.data);
    } else {
      print('response is not oky');
      return productModel;
    }
  } catch (e) {
    print('Error $e');
    return productModel;
  }
}

Future<List<GetProductModel>> getProducts() async {
  try {
    final response = await Dio().get(getProductUrl,
        options: Options(headers: {'Authorization': 'Bearer $globalToken'}));
    print(response.data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      List<GetProductModel> products = (response.data['data'] as List)
          .map((json) => GetProductModel.fromJson(json))
          .toList();
      return products;
    } else {
      print('Failed to Fetch Products');
      return [];
    }
  } catch (e) {
    print('Error Fetching Products $e');
    return [];
  }
}

String deleteProductMessage = "";
Future<void> deleteProduct(String id, BuildContext context) async {
  print('Delete product called');
  try {
    final response = await Dio().delete('$deleteProductUrl/$id',
        options: Options(headers: {'Authorization': 'Bearer $globalToken'}));
    print(response);
    if (response.statusCode == 200 || response.statusCode == 201) {
      deleteProductMessage = response.data['message'];
      productShowSnackBar(context, deleteResponseMessage);
    }
  } catch (e) {
    print('Error in Delete Category $e');
  }
}

Future<EditProductModel> editProduct(
    List<File?> image,
    String name,
    int price,
    String description,
    int stock,
    String category,
    String authtoken,
    String message,
    BuildContext context) async {
  EditProductModel editProductModel = EditProductModel(
      category: "",
      description: "",
      id: "",
      images: image,
      name: "",
      price: 0,
      stock: 0);
  try {
    List<MultipartFile?> imageFiles = image.map((image) {
      if (image != null) {
        return MultipartFile.fromFileSync(image.path,
            filename: image.path.split('/').last);
      } else {
        return null;
      }
    }).toList();
    FormData formData = FormData.fromMap({
      "image": imageFiles,
      "name": name,
      "price": price,
      "description": description,
      "stock": stock,
      "category": category
    });
    final response = await Dio().patch(editProductUrl,
        data: formData,
        options: Options(headers: {'Authorization': 'Bearer $authtoken'}));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Response -------message: ${response.data['message']}');
      String responseMessage = response.data['message'] ?? "";
      productShowSnackBar(context, responseMessage);
      return EditProductModel.fromJson(response.data);
    } else {
      return editProductModel;
    }
  } catch (e) {
    print('Error Editing product $e');
    return editProductModel;
  }
}

void productShowSnackBar(BuildContext context, String message) {
  print('snackbar is called');
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: const TextStyle(color: kWhite),
    ),
  ));
}
