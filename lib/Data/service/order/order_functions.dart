import 'package:admin/Application/Presentation/utils/colors.dart';
import 'package:admin/Data/service/auth/autherization_functions.dart';
import 'package:admin/Data/service/order/config.dart';
import 'package:admin/Domain/models/order/get_order_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class OrderService {
  Future<List<GetOrderModel>> getOrders() async {
    String? orderToken = await getAuthToken();
    try {
      final response = await Dio().get(getOrderUrl,
          options: Options(headers: {'Authorization': '$orderToken'}));
      // print('Get Orders-----${response.data}');
      List<dynamic> responseData = response.data['data'];
      List<GetOrderModel> results = [];
      for (var data in responseData) {
        if (data.containsKey('products') && data['products'] is List) {
          List<dynamic> productData = data['products'];
          for (var product in productData) {
            GetOrderModel orderModel = GetOrderModel.fromJson(product);
            results.add(orderModel);
          }
        }
      }
      return results;
    } catch (e) {
      print('Error Fetching orders $e');
      return [];
    }
  }

  Future<List<GetOrderProductModel>> getOrderProduct() async {
    String? orderToken = await getAuthToken();
    try {
      final response = await Dio().get(getOrderUrl,
          options: Options(headers: {'Authorization': '$orderToken'}));
      print('Get orders====${response.data}');
      List<GetOrderProductModel> orders = (response.data['data'] as List)
          .map((json) => GetOrderProductModel.fromJson(json))
          .toList();
      return orders;
    } catch (e) {
      return [];
    }
  }

  Future<void> changeStatus(String status, BuildContext context) async {
    String? orderToken = await getAuthToken();
    var data = {'orderStatus': status};
    try {
      final response = await Dio().post(changeOrderStatusUrl,
          options: Options(headers: {'Authorization': '$orderToken'}),
          data: data);
      String orderMessage = response.data['message'];
      orderShowSnackBar(context, orderMessage);
    } catch (e) {
      print('Error Updating Status $e');
    }
  }
}

void orderShowSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: const TextStyle(color: kWhite),
    ),
  ));
}
