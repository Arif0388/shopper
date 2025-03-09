
import 'package:desi_mart/Config/Theme.dart';
import 'package:desi_mart/Pages/AuthPage/Login.dart';
import 'package:desi_mart/Pages/AuthPage/Signup.dart';
import 'package:desi_mart/Pages/Splash_Screen/Splash_Screen.dart';
import 'package:desi_mart/Pages/WelcomePage/WelcomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor:Color(0xff019934),
  //   statusBarIconBrightness:Brightness.dark
  // ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner:false,
      title: 'Flutter Demo',
      theme: lightTheme,
      themeMode:ThemeMode.light,
      // home:WelcomePage(),
      home:SplashScreen(),
      builder:EasyLoading.init(),
    );
  }
}
