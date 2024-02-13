import 'dart:convert';
import 'dart:io';

import 'package:admin/Application/Presentation/utils/colors.dart';
import 'package:admin/Data/service/product/config.dart';
import 'package:admin/Domain/models/product/product_model.dart';
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

void productShowSnackBar(BuildContext context, String message) {
  print('snackbar is called');
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: const TextStyle(color: kWhite),
    ),
  ));
}
