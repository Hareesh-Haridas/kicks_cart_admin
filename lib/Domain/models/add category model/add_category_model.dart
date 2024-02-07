import 'package:admin/Data/service/auth/config.dart';

class BrandModel {
  final String name;
  final dynamic image;

  BrandModel({required this.name, required this.image});
  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
        name: json['name'] ?? "",
        image: json['image'] != null
            ? '$baseUrl/categories/' + json['image'].toString()
            : "");
  }
}
