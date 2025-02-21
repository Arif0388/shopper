
import 'package:desi_mart/Config/AssetsPath.dart';
import 'package:desi_mart/Controller/authController.dart';
import 'package:desi_mart/Pages/HomePage/HomePage.dart';
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
AuthController authController  = Get.put(AuthController());
  @override
  void initState()
  {
    super.initState();
  controller = AnimationController(vsync:this,duration:const Duration(seconds:2))..repeat(reverse:true);
  animation = Tween<double>(begin:0.8,end:1.0).animate(CurvedAnimation(parent: controller, curve:Curves.easeInOut));
  SplashController();
  }

  Future<void> SplashController()async{
    await Future.delayed(const Duration(seconds:3)).then((value){
     if(authController.auth.currentUser!=null)
       {
         Get.offAll(HomePage());
       }else{
       Get.offAll(WelcomePage());
     }


    });
  }

  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor:Theme.of(context).colorScheme.primary,
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
