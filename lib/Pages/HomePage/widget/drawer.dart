import 'package:desi_mart/Controller/authController.dart';
import 'package:desi_mart/Pages/AuthPage/Signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class drawer extends StatelessWidget {
  const drawer({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    return SingleChildScrollView(
      scrollDirection:Axis.vertical,
      child: Column(
        children: [
          DrawerHeader(
            child:Row(
              children: [
                CircleAvatar(
                  radius:40,
                  child:Text('A',style:Theme.of(context).textTheme.labelLarge),
                ),
                const SizedBox(width:25),
                Column(
                  children: [
                    const SizedBox(height:30),
                    Text('.......',style:Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height:10),
                    OutlinedButton(
                        onPressed:(){
                        }, child: authController.auth.currentUser!=null?  InkWell(
                        onTap:(){
                          authController.logout();
                          Get.offAll(SignUp());
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
