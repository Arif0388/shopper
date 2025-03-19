class OrderModel {
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
  int? productQuantity;
  double? productTotalPrice;
  String? customerId;
  String? customerName;
  String? customerPhone;
  String? customerDeviceToken;
  String? customerAddress;
  bool? status;

  OrderModel({
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
    this.productQuantity,
    this.productTotalPrice,
    this.customerAddress,
    this.customerId,
    this.customerName,
    this.customerPhone,
    this.status,
    this.customerDeviceToken
  });

  // Convert JSON to Product object
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
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
      productTotalPrice: json['productTotalPrice'] ?? '',
      productQuantity: json['productQuantity'] ?? '',
      customerAddress:json['customerAddress'] ?? '' ,
      customerId:   json['customerId'] ?? '',
      customerName:  json['customerName'] ?? '',
      customerPhone:     json['customerPhone'] ?? '',
      status:        json['status'] ?? '',
      customerDeviceToken:        json['customerDeviceToken'] ?? '',
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
      'productQuantity': productQuantity,
      'productTotalPrice': productTotalPrice,
      'customerAddress':customerAddress,
      'customerId':customerId,
      'customerName':customerName,
       'customerPhone':customerPhone,
        'status':status,
      'customerDeviceToken':customerDeviceToken
  };
  }
}
