import 'package:desi_mart/ApiService/ApiService.dart';
import 'package:desi_mart/Config/AssetsPath.dart';
import 'package:desi_mart/Config/Page_Routes.dart';
import 'package:desi_mart/Pages/WelcomePage/WelcomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{

late AnimationController controller;
late Animation<double> animation;

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
    //
    // if(ApiService.auth.currentUser !=null)
    //   {
    //      context.go('/homePage');
    //   }
    // else
    //   {
    //     context.go('/signupPage');
    //   }
    // context.go('/loginPage');

      context.go('/productDetailPage');
      // context.go('/categoryPage');

    });
  }

  @override
  void dispose()
  {
    controller.dispose();
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
              child:SvgPicture.asset(IconsPath.appLogo),
            ),
          ),
          SizedBox(height:300),
          Center(child: Text("@Made By Arif",style:Theme.of(context).textTheme.bodySmall)),
        ],
      )
    );
  }
}
