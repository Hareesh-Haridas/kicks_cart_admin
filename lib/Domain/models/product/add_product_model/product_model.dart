import 'package:admin/Data/service/auth/config.dart';

class ProductModel {
  final List<dynamic> productImage;
  final String productName;
  final int productPrice;
  final String productDescription;
  final int stock;
  final String category;
  String message;
  ProductModel({
    required this.productImage,
    required this.productName,
    required this.productPrice,
    required this.productDescription,
    required this.stock,
    required this.category,
    required this.message,
  });
  Map<String, dynamic> toJson() {
    return {
      'image': productImage,
      'name': productName,
      'price': productPrice,
      'description': productDescription,
      'stock': stock,
      'category': category
    };
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      message: "",
      productImage:
          json['image'] != null ? ['$baseUrl/addProduct/${json['image']}'] : [],
      productName: json['name'] ?? '',
      productPrice: json['price'] ?? 0,
      productDescription: json['description'] ?? '',
      stock: json['stock'] ?? 0,
      category: json['category'] ?? '',
    );
  }
}
