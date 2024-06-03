class GetProductModel {
  final String id;
  final List<dynamic> images;
  final String name;
  final int price;
  final String description;
  final int stock;
  final String category;
  final bool blocked;
  GetProductModel(
      {required this.id,
      required this.images,
      required this.name,
      required this.price,
      required this.description,
      required this.stock,
      required this.category,
      required this.blocked});
  factory GetProductModel.fromJson(Map<String, dynamic> json) {
    return GetProductModel(
        id: json['_id'] != null ? json['_id'].toString() : "",
        images: json['image'] != null ? List.from(json['image']) : [],
        name: json['name'] ?? "",
        price: json['price'] ?? 0,
        description: json['description'] ?? "",
        stock: json['stock'] ?? 0,
        category: json['category'] ?? "",
        blocked: json['blocked'] ?? false);
  }
}
