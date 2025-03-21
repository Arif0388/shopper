import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desi_mart/Controller/get_device_token_controller.dart';
import 'package:desi_mart/Models/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class AuthController extends GetxController
{
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  RxBool isPasswordVisible = false.obs;

  Future<UserCredential?> SignUpMethod(String userName, String userEmail, String userPhone, String userCity, String userPassword, String userDeviceToken)async
  {
    try{
      EasyLoading.show(status:'Please Wait...');
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(email:userEmail, password:userPassword);
    //   send email verification
      await userCredential.user!.sendEmailVerification();

      UserModel userModel = UserModel(
        uid:userCredential.user!.uid,
        userEmail:userEmail,
        userPhone:userPhone,
        userImage:'',
        userDeviceToken:userDeviceToken,
        userCountry:'',
        userAddress:'',
        userStreet:'',
        isAdmin:false,
        isActive:true,
        createdOn:DateTime.now(),
        city:userCity,
        userName:userName,
      );
       db.collection('Users').doc(userCredential.user!.uid).set(userModel.toJson());
      EasyLoading.dismiss();
       return userCredential;
    }catch(ex){
      EasyLoading.dismiss();
      Get.snackbar("Error",'$ex',
      snackPosition:SnackPosition.BOTTOM,
        backgroundColor:Colors.red,
        colorText:Colors.white
      );
    }
  }

}