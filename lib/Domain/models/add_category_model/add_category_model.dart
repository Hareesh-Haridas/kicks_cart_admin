// import 'package:admin/Data/service/auth/config.dart';

import 'package:admin/data/service/auth/config.dart';

class BrandModel {
  final bool blocked;
  final String name;
  final dynamic image;
  final String id;
  BrandModel(
      {required this.name,
      required this.image,
      required this.id,
      required this.blocked});
  factory BrandModel.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('data')) {
      var data = json['data'] as List<dynamic>;
      if (data.isNotEmpty) {}
    }
    return BrandModel(
        name: json['name'] ?? "",
        image:
            json['image'] != null ? '$baseUrl/categories/${json['image']}' : "",
        id: json['_id'] != null ? json['_id'].toString() : "",
        blocked: json['blocked'] ?? false);
  }
}
