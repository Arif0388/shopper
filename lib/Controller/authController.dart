import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desi_mart/Pages/HomePage/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController
{





  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;

  Future<void> signup()async{
    isLoading.value = true;
   if(email.text !='' && password !='')
     {
       await auth.createUserWithEmailAndPassword(email:email.text, password:password.text);
       Get.offAll(HomePage());
     }
   else
     {
       Get.snackbar('Error','Please fill all required Field',
       borderRadius:20,
         snackPosition:SnackPosition.BOTTOM,
         backgroundColor:Colors.red,
         colorText:Colors.white,
       );
    }
    isLoading.value = false;
  }

  Future<void> login()async{
    isLoading.value = true;
    if(email.text !='' && password !='')
      {
        await auth.signInWithEmailAndPassword(email: email.text, password: password.text);
        Get.offAll(HomePage());
      }
    else{
      Get.snackbar('Error','Please fill all required Field',
        borderRadius:20,
        snackPosition:SnackPosition.BOTTOM,
        backgroundColor:Colors.red,
        colorText:Colors.white,
      );
    }
    isLoading.value = false;
  }

  Future<void> logout()async{
    await auth.signOut();
  }
}