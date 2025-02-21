class UserModel {
  UserModel({
      this.name, 
      this.email, 
      this.createdAt,});

  UserModel.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    createdAt = json['created At'];
  }
  String? name;
  String? email;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['created At'] = createdAt;
    return map;
  }

}