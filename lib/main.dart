import 'package:desi_mart/Config/Page_Routes.dart';
import 'package:desi_mart/Config/Theme.dart';
import 'package:desi_mart/Pages/HomePage/HomePage.dart';
import 'package:desi_mart/Pages/Splash_Screen/Splash_Screen.dart';
import 'package:desi_mart/Pages/WelcomePage/WelcomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor:Color(0xff019934),
    statusBarIconBrightness:Brightness.dark
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner:false,
      title: 'Flutter Demo',
      theme: lightTheme,
      themeMode:ThemeMode.light,
      routerConfig:router,
    );
  }
}
