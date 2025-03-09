class ProductModel {
  String? productId;
  String? productName;
  String? categoryId;
  String? categoryName;
  bool? isSale;
  String? salePrice;
  String? fullPrice;
  String? productDescription;
  String? deliveryTime;
  dynamic createdAt;
  dynamic updatedAt;
  List<dynamic>? productImages;

  ProductModel({
 this.productId,
 this.productName,
 this.categoryId,
 this.categoryName,
 this.isSale,
 this.salePrice,
 this.fullPrice,
 this.productDescription,
 this.deliveryTime,
 this.createdAt,
 this.updatedAt,
 this.productImages,
  });

  // Convert JSON to Product object
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json['productId'] ?? '',
      productName: json['productName'] ?? '',
      categoryId: json['categoryId'] ?? '',
      categoryName: json['categoryName'] ?? '',
      isSale: json['isSale'] ?? '',
      salePrice: json['salePrice'] ?? '',
      fullPrice: json['fullPrice'] ?? '',
      productDescription: json['productDescription'] ?? '',
      deliveryTime: json['deliveryTime'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      productImages: List<dynamic>.from(json['productImages'] ?? ''),
    );
  }

  // Convert Product object to JSON
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'isSale': isSale,
      'salePrice': salePrice,
      'fullPrice': fullPrice,
      'productDescription': productDescription,
      'deliveryTime': deliveryTime,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'productImages': productImages,
    };
  }
}
