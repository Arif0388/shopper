import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetDeviceTokenController extends GetxController
{
  String? deviceToken;

  @override
  void onInit(){
    super.onInit();
    getDeviceToken();
  }


  Future<void> getDeviceToken()async{
    try{
         String? token = await FirebaseMessaging.instance.getToken();
         if(token !=null)
           {
             deviceToken = token;
             update();
             print('Device Token :$deviceToken');
      }
    }catch(ex){
      Get.snackbar("Error",'$ex',
          snackPosition:SnackPosition.BOTTOM,
          backgroundColor:Colors.red,
          colorText:Colors.white
      );
    }
  }

}