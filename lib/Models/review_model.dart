class ReviewModel {
  String? customerName;
  String? customerPhone;
  String? customerDeviceToken;
  String? customerId;
  String? createdAt;
  String? rating;
  String? feedback;

  ReviewModel({
    this.customerDeviceToken,
  this.customerPhone,
  this.customerName,
    this.customerId,
    this.createdAt,
    this.rating,
    this.feedback
  });

  ReviewModel.fromJson(dynamic json) {
    customerDeviceToken = json['customerDeviceToken'] ?? '';
    customerPhone = json['customerPhone'] ?? '';
    customerName = json['customerName'] ?? '';
    customerId = json['customerId'] ?? '';
    createdAt = json['createdAt'] ?? '';
    rating = json['rating'] ?? '';
    feedback = json['feedback'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['customerDeviceToken'] = customerDeviceToken;
    map['customerPhone'] = customerPhone;
    map['customerName'] = customerName;
    map['createdAt'] = createdAt;
    map['customerId'] = customerId;
    map['createdAt'] = createdAt;
    map['rating'] = rating;
    map['feedback'] = feedback;
    return map;
  }

}