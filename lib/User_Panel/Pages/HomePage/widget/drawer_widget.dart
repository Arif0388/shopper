import 'package:cached_network_image/cached_network_image.dart';
import 'package:desi_mart/Controller/google_sign_in_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../WelcomePage/WelcomePage.dart';
import '../../all_orders_page/all_orders_page.dart';

class drawer extends StatelessWidget {
  const drawer({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
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
                         child: CachedNetworkImage(fit:BoxFit.cover, imageUrl:user!.photoURL!)
                     ),
                   ),
                const SizedBox(width:25),
                Column(
                  children: [
                    const SizedBox(height:30),
                      Text(user.displayName!,style:Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height:10),
                       OutlinedButton(
                           onPressed:(){
                           }, child: googleSignInController.auth.currentUser!=null?  InkWell(
                           onTap:()async{
                             GoogleSignIn googleSignIn = GoogleSignIn();
                             FirebaseAuth _auth = FirebaseAuth.instance;
                             await  _auth.signOut();
                             await googleSignIn.signOut();
                             Get.offAll(WelcomePage());
                           },
                           child: Text('Logout',style:Theme.of(context).textTheme.bodyMedium)) : Text('login',style:Theme.of(context).textTheme.bodyMedium)
                       ),
                  ],
                ),
              ],
            ),
          ),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal:10,vertical:10),
           child: ListTile(
             titleAlignment:ListTileTitleAlignment.center,
             title:Text('Home',style:Theme.of(context).textTheme.headlineSmall),
             leading:Icon(Icons.home,color:Colors.yellow,),
             trailing:Icon(Icons.arrow_circle_right_outlined,color:Colors.orangeAccent,),
           ),
         ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:10,vertical:10),
            child: ListTile(
              titleAlignment:ListTileTitleAlignment.center,
              title:Text('Products',style:Theme.of(context).textTheme.headlineSmall),
              leading:Icon(Icons.production_quantity_limits,color:Colors.pinkAccent,),
              trailing:Icon(Icons.arrow_circle_right_outlined,color:Colors.orangeAccent,),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:10,vertical:10),
            child: ListTile(
              onTap:(){
                Get.to(AllOrdersPagePage());
              },
              titleAlignment:ListTileTitleAlignment.center,
              title:Text('Orders',style:Theme.of(context).textTheme.headlineSmall),
              leading:Icon(Icons.shopping_bag_rounded,color:Colors.tealAccent,),
              trailing:Icon(Icons.arrow_circle_right_outlined,color:Colors.orangeAccent,),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:10,vertical:10),
            child: ListTile(
              titleAlignment:ListTileTitleAlignment.center,
              title:Text('Contact',style:Theme.of(context).textTheme.headlineSmall),
              leading:Icon(Icons.question_mark,color:Colors.black87,),
              trailing:Icon(Icons.arrow_circle_right_outlined,color:Colors.orangeAccent,),
            ),
          ),
          Container(
            alignment:Alignment.center,
            child:Text('Version : 1.0.1'),
          ),
          Container(
            alignment:Alignment.center,
            child:Text('Developer : Mr Arif Hussain'),
          ),
        ],
      ),
    );
  }
}
