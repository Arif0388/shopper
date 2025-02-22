import 'package:desi_mart/Controller/authController.dart';
import 'package:desi_mart/Controller/google_sign_in_controller.dart';
import 'package:desi_mart/Pages/AuthPage/Signup.dart';
import 'package:desi_mart/Pages/WelcomePage/WelcomePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class drawer extends StatelessWidget {
  const drawer({super.key});

  @override
  Widget build(BuildContext context) {
    GoogleSignInController googleSignInController = Get.put(GoogleSignInController());
    return SingleChildScrollView(
      scrollDirection:Axis.vertical,
      child: Column(
        children: [
          DrawerHeader(
            child:Row(
              children: [
                CircleAvatar(
                  radius:40,
                  child:ClipRRect(
                      borderRadius:BorderRadius.circular(50),
                      child: Image.network(fit:BoxFit.cover,googleSignInController.auth.currentUser!.photoURL.toString())),
                ),
                const SizedBox(width:25),
                Column(
                  children: [
                    const SizedBox(height:30),
                    Text(googleSignInController.auth.currentUser!.displayName!,style:Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height:10),
                    OutlinedButton(
                        onPressed:(){
                        }, child: googleSignInController.auth.currentUser!=null?  InkWell(
                        onTap:(){
                         googleSignInController.signOut();
                          Get.offAll(WelcomePage());
                        },
                        child: Text('Logout',style:Theme.of(context).textTheme.bodyMedium)) : Text('login',style:Theme.of(context).textTheme.bodyMedium)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
