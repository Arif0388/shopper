class CategoryModel {
  CategoryModel({
      this.categoryId, 
      this.categoryName, 
      this.categoryImg, 
      this.createdAt, 
      this.updatedAt,});

  CategoryModel.fromJson(dynamic json) {
    categoryId = json['categoryId'] ?? '';
    categoryName = json['categoryName'] ?? '';
    categoryImg = json['categoryImg'] ?? '';
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updatedAt'] ?? '';
  }
  String? categoryId;
  String? categoryName;
  String? categoryImg;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['categoryId'] = categoryId;
    map['categoryName'] = categoryName;
    map['categoryImg'] = categoryImg;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }

}