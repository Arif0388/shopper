
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SignInController extends GetxController
{
  FirebaseAuth auth = FirebaseAuth.instance;
  RxBool isPasswordVisible = false.obs;

  Future<UserCredential?> SignInMethod(String userEmail,String userPassword)async
  {
    try{
      EasyLoading.show(status:'Please Wait...');
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email:userEmail, password:userPassword);
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