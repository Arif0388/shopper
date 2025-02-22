import 'package:desi_mart/Config/AssetsPath.dart';
import 'package:desi_mart/Controller/google_sign_in_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sign_in_button/sign_in_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    GoogleSignInController googleSignInController = Get.put(GoogleSignInController());
    return Scaffold(
      backgroundColor:Theme.of(context).colorScheme.primary,
      body: Column(
        children: [
          Container(
            padding:const EdgeInsets.all(5),
            margin:const EdgeInsets.symmetric(vertical:50,horizontal:25),
            // width:335,
            // height:400,
            decoration:BoxDecoration(
              borderRadius:BorderRadius.circular(20),
              color:Theme.of(context).colorScheme.onSurface,
            ),
            child:Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  // SvgPicture.asset(IconsPath.appLogoBanner),
                 Row(children: [
                   Expanded(flex:0,child: Image.asset(ImagesPath.appLogo,width:80,)),
                   SizedBox(width:10),
                   Expanded(child: Text('Welcome To Shopper',style:Theme.of(context).textTheme.labelLarge))
                 ],),
                 const SizedBox(height:50,),
                 Row(children: [
                   const SizedBox(width:10,),
                   SvgPicture.asset(IconsPath.leaf),
                   Text('   Organic Groceries ',
                       style:Theme.of(context).textTheme.bodyMedium?.copyWith(color:Theme.of(context).colorScheme.onPrimaryContainer)),
                 ],
                 ),
                   Divider(color:Theme.of(context).colorScheme.onPrimaryContainer,indent:10,endIndent:20,),
                  const SizedBox(height:8,),
                  Row(children: [
                    const SizedBox(width:10,),
                    SvgPicture.asset(IconsPath.foods),
                    Text('   Whole foods and vegitable',
                        style:Theme.of(context).textTheme.bodyMedium?.copyWith(color:Theme.of(context).colorScheme.onPrimaryContainer)),
                  ],
                  ),
                  Divider(color:Theme.of(context).colorScheme.onPrimaryContainer,indent:10,endIndent:20,),
                  const SizedBox(height:8,),
                  Row(children: [
                    const SizedBox(width:10,),
                    SvgPicture.asset(IconsPath.vehicle),
                    Text('   Fast Delivery',
                        style:Theme.of(context).textTheme.bodyMedium?.copyWith(color:Theme.of(context).colorScheme.onPrimaryContainer)),
                  ],
                  ),
                  Divider(color:Theme.of(context).colorScheme.onPrimaryContainer,indent:10,endIndent:20,),
                  const SizedBox(height:8,),
                  Row(children: [
                    const SizedBox(width:10,),
                    SvgPicture.asset(IconsPath.money),
                    Text('   East Refund and return',
                        style:Theme.of(context).textTheme.bodyMedium?.copyWith(color:Theme.of(context).colorScheme.onPrimaryContainer)),
                  ],
                  ),
                  Divider(color:Theme.of(context).colorScheme.onPrimaryContainer,indent:10,endIndent:20,),
                  const SizedBox(height:8,),
                  Row(children: [
                    const SizedBox(width:10,),
                    SvgPicture.asset(IconsPath.secure),
                    Text('   Secure and safe',
                        style:Theme.of(context).textTheme.bodyMedium?.copyWith(color:Theme.of(context).colorScheme.onPrimaryContainer)),
                  ],
                  ),
                ],
              ),
            ),
          ),
           Text("Welcome to our Store",style:Theme.of(context).textTheme.headlineLarge,),
          const SizedBox(height:5),
           Text("""Get your grocery in as fast as 
                 one hours""",style:Theme.of(context).textTheme.bodyMedium,),
          SizedBox(height:50),
          SizedBox(
            width:280,
            height:50,
            child: SignInButton(
                elevation:5,
                Buttons.google, onPressed:(){
                  googleSignInController.signInWithGoogle();
            }
            ),
          ),
          SizedBox(height:20),
          SizedBox(
            width:280,
            height:50,
            child: SignInButton(
                elevation:5,
                Buttons.email, onPressed:(){}
            ),
          ),
        ],
      )
    );
  }
}
