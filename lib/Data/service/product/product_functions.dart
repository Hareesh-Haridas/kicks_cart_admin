import 'dart:io';
import 'package:admin/Application/Presentation/utils/colors.dart';
import 'package:admin/Data/service/auth/autherization_functions.dart';
import 'package:admin/Data/service/category/category_functions.dart';
import 'package:admin/Data/service/product/config.dart';
import 'package:admin/Domain/models/product/edit%20product%20model/edit_product.dart';
import 'package:admin/Domain/models/product/get%20product%20model/get_product_model.dart';
import 'package:admin/Domain/models/product/add%20product%20model/product_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ProductService {
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
        String responseMessage = response.data['message'] ?? "";
        productShowSnackBar(context, responseMessage);
        return ProductModel.fromJson(response.data);
      } else {
        return productModel;
      }
    } catch (e) {
      return productModel;
    }
  }

  Future<List<GetProductModel>> getProducts() async {
    try {
      final response = await Dio().get(getProductUrl,
          options: Options(headers: {'Authorization': 'Bearer $globalToken'}));

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<GetProductModel> products = (response.data['data'] as List)
            .map((json) => GetProductModel.fromJson(json))
            .toList();
        return products;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  String deleteProductMessage = "";
  Future<void> deleteProduct(String id, BuildContext context) async {
    try {
      final response = await Dio().delete('$deleteProductUrl/$id',
          options: Options(headers: {'Authorization': 'Bearer $globalToken'}));

      if (response.statusCode == 200 || response.statusCode == 201) {
        deleteProductMessage = response.data['message'];
        productShowSnackBar(context, deleteProductMessage);
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
      BuildContext context,
      String id) async {
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
        "category": category,
        "id": id,
      });
      final response = await Dio().patch(editProductUrl,
          data: formData,
          options: Options(headers: {'Authorization': 'Bearer $authtoken'}));
      if (response.statusCode == 200 || response.statusCode == 201) {
        String responseMessage = response.data['message'] ?? "";
        productShowSnackBar(context, responseMessage);
        Navigator.of(context).pop();
        return EditProductModel.fromJson(response.data);
      } else {
        return editProductModel;
      }
    } catch (e) {
      return editProductModel;
    }
  }

  Future<List<GetProductModel>> searchProducts(String letters) async {
    try {
      final response = await Dio().get(searchProductUrl,
          options: Options(headers: {'Authorization': 'Bearer $globalToken'}));
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<GetProductModel> products = (response.data['data'] as List)
            .map((json) => GetProductModel.fromJson(json))
            .toList();
        return products;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<List<GetProductModel>> getSearchedProducts(String query) async {
    try {
      final response = await Dio().get('$searchProductUrl/$query',
          options: Options(headers: {'Authorization': 'Bearer $globalToken'}));

      bool status = response.data['status'];
      if (status) {
        List<GetProductModel> products = (response.data['data'] as List)
            .map((json) => GetProductModel.fromJson(json))
            .toList();
        return products;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<GetProductModel> fetchProductDetail(String id) async {
    try {
      final response = await Dio().get('$fetchProductUrl/$id',
          options: Options(headers: {'Authorization': 'Bearer $globalToken'}));
      if (response.statusCode == 200 || response.statusCode == 201) {
        GetProductModel getProductModel =
            GetProductModel.fromJson(response.data['data']);
        return getProductModel;
      } else {
        return GetProductModel(
            id: '',
            images: [],
            name: "",
            price: 0,
            description: "",
            stock: 0,
            category: "");
      }
    } catch (e) {
      return GetProductModel(
          id: '',
          images: [],
          name: "",
          price: 0,
          description: "",
          stock: 0,
          category: "");
    }
  }
}

void productShowSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: const TextStyle(color: kWhite),
    ),
  ));
}
