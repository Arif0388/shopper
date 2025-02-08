import 'package:desi_mart/Pages/AuthPage/Login.dart';
import 'package:desi_mart/Pages/AuthPage/Signup.dart';
import 'package:desi_mart/Pages/CategoryPage/Category.dart';
import 'package:desi_mart/Pages/HomePage/HomePage.dart';
import 'package:desi_mart/Pages/Product_Details/Product_Details.dart';
import 'package:desi_mart/Pages/Splash_Screen/Splash_Screen.dart';
import 'package:desi_mart/Pages/WelcomePage/WelcomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

var router = GoRouter(
    routes:[
      GoRoute(
          path:'/',
           builder:(BuildContext context,GoRouterState state){
            return const SplashScreen();
           },
      ),
      GoRoute(
        path:'/welcome',
        builder:(BuildContext context,GoRouterState state){
          return const Welcomepage();
        },
      ),
      GoRoute(
        path:'/homePage',
        builder:(BuildContext context,GoRouterState state){
          return const HomePage();
        },
      ),

      GoRoute(
        path:'/signupPage',
        builder:(BuildContext context,GoRouterState state){
          return const SignUp();
        },
      ),
      GoRoute(
        path:'/loginPage',
        builder:(BuildContext context,GoRouterState state){
          return const Login();
        },
      ),

      GoRoute(
        path:'/categoryPage',
        builder:(BuildContext context,GoRouterState state){
          return const Category();
        },
      ),

      GoRoute(
        path:'/productDetailPage',
        builder:(BuildContext context,GoRouterState state){
          return const ProductDetails();
        },
      ),
    ]
);