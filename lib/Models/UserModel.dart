class UserModel {
  UserModel({
      this.uid, 
      this.userName, 
      this.userEmail, 
      this.userPhone, 
      this.userImage, 
      this.userDeviceToken, 
      this.userCountry, 
      this.userStreet, 
      this.userAddress, 
      this.isAdmin, 
      this.isActive, 
      this.createdOn,});

  UserModel.fromJson(dynamic json) {
    uid = json['Uid'];
    userName = json['userName'];
    userEmail = json['userEmail'];
    userPhone = json['userPhone'];
    userImage = json['userImage'];
    userDeviceToken = json['userDeviceToken'];
    userCountry = json['userCountry'];
    userStreet = json['userStreet'];
    userAddress = json['userAddress'];
    isAdmin = json['isAdmin'];
    isActive = json['isActive'];
    createdOn = json['createdOn'].toString();
  }
  String? uid;
  String? userName;
  String? userEmail;
  String? userPhone;
  String? userImage;
  String? userDeviceToken;
  String? userCountry;
  String? userStreet;
  String? userAddress;
  bool? isAdmin;
  bool? isActive;
  dynamic createdOn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Uid'] = uid;
    map['userName'] = userName;
    map['userEmail'] = userEmail;
    map['userPhone'] = userPhone;
    map['userImage'] = userImage;
    map['userDeviceToken'] = userDeviceToken;
    map['userCountry'] = userCountry;
    map['userStreet'] = userStreet;
    map['userAddress'] = userAddress;
    map['isAdmin'] = isAdmin;
    map['isActive'] = isActive;
    map['createdOn'] = createdOn;
    return map;
  }

}