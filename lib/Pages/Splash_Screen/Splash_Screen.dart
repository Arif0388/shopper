
import 'dart:async';

import 'package:desi_mart/Config/AssetsPath.dart';
import 'package:desi_mart/Config/Colors.dart';
import 'package:desi_mart/Controller/get_user_data_controller.dart';
import 'package:desi_mart/Pages/AdminPage/adminPage.dart';
import 'package:desi_mart/Pages/HomePage/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../WelcomePage/WelcomePage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{

late AnimationController controller;
late Animation<double> animation;
GetUserDataController getUserDataController = Get.put(GetUserDataController());
  @override
  void initState()
  {
    super.initState();
  controller = AnimationController(vsync:this,duration:const Duration(seconds:2))..repeat(reverse:true);
  animation = Tween<double>(begin:0.8,end:1.0).animate(CurvedAnimation(parent: controller, curve:Curves.easeInOut));
   Timer(Duration(seconds:3),(){
     SplashController();
   });
  }

 Future<void> SplashController()async{
    User? user = FirebaseAuth.instance.currentUser;
    if(user!= null)
      {
        var userData = await getUserDataController.getUserData(user.uid);
        if(userData[0]['isAdmin']==true){
          Get.offAll(AdminPage());
        }else{
          Get.offAll(HomePage());
        }
      }else{
      Get.offAll(WelcomePage());
    }

 }

  void dispose(){
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor:ownColor2,
      body:Column(
        children: [
          SizedBox(height:250),
          Center(
            child:ScaleTransition(
              alignment:Alignment.center,
                scale:animation,
              child:Image.asset(ImagesPath.appLogo,width:200,),
            ),
          ),
          SizedBox(height:300),
          Center(child: Text("@Made By Arif",style:Theme.of(context).textTheme.bodySmall)),
        ],
      )
    );
  }
}
