import 'package:desi_mart/Pages/AuthPage/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController
{
  FirebaseAuth _auth  = FirebaseAuth.instance;

  Future<void> forgetPassword(String email)async{
    EasyLoading.show(status:'Please Wait......');
   try{
     await _auth.sendPasswordResetEmail(email: email);
     Get.offAll(Login());
     EasyLoading.dismiss();
     Get.snackbar("Send Message",'Sent your email Please check email',
         snackPosition:SnackPosition.BOTTOM,
         backgroundColor:Colors.teal,
         colorText:Colors.white
     );
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