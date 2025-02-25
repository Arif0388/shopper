
import 'package:desi_mart/Config/AssetsPath.dart';
import 'package:desi_mart/Controller/sign_up_controller.dart';
import 'package:desi_mart/Pages/AuthPage/Login.dart';
import 'package:desi_mart/Pages/HomePage/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../Controller/get_device_token_controller.dart';
class SignUp extends StatelessWidget {
    const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    GetDeviceTokenController getDeviceTokenController = Get.put(GetDeviceTokenController());
    TextEditingController name = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController phone = TextEditingController();
    TextEditingController city = TextEditingController();
    return KeyboardVisibilityBuilder(builder:(context, isKeyboardVisible) {
      return SafeArea(
        child: Scaffold(
          backgroundColor:Theme.of(context).colorScheme.primary,
          body:Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height:70,),
                  Center(child: Text("Sign up",style:Theme.of(context).textTheme.headlineLarge)),
                  SizedBox(height:70,),
                  Container(
                    padding:EdgeInsets.only(top:15),
                    // width:350,
                    // height:520,
                    // width:Get.width,
                    decoration:BoxDecoration(
                      borderRadius:BorderRadius.circular(16),
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                    child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [

                          // for name
                          Row(
                            children: [
                              SizedBox(height:10,),
                              Text('   Full Name',style:Theme.of(context).textTheme.labelMedium),
                            ],
                          ),

                          Container(
                            width:310,
                            height:49,
                            margin:EdgeInsets.symmetric(vertical:10),
                            decoration:BoxDecoration(
                              borderRadius:BorderRadius.circular(15),
                              color:Colors.orange,
                            ),
                            child:TextFormField(
                              keyboardType:TextInputType.name,
                              controller:name,
                              style:Theme.of(context).textTheme.bodySmall,
                              cursorColor:Colors.black87,
                              decoration:InputDecoration(
                                border:OutlineInputBorder(
                                    borderRadius:BorderRadius.circular(15)
                                ),
                                hintText:'Enter Name',
                                suffixIcon:Icon(Icons.person,color:Colors.white,),
                              ),
                            ),
                          ),
                          SizedBox(height:5),

                          //for email

                          Row(
                            children: [
                              SizedBox(height:10,),
                              Text('   Email id',style:Theme.of(context).textTheme.labelMedium),
                            ],
                          ),
                          Container(
                            width:310,
                            height:49,
                            margin:EdgeInsets.symmetric(vertical:10),
                            decoration:BoxDecoration(
                              borderRadius:BorderRadius.circular(15),
                              color:Colors.orange,
                            ),
                            child:TextField(
                              keyboardType:TextInputType.emailAddress,
                              controller:email,
                              style:Theme.of(context).textTheme.bodySmall,
                              cursorColor:Colors.black87,
                              decoration:InputDecoration(
                                border:OutlineInputBorder(
                                    borderRadius:BorderRadius.circular(15)
                                ),
                                hintText:'Enter Email',
                                suffixIcon:Icon(Icons.alternate_email_outlined,color:Colors.white,),
                              ),
                            ),
                          ),

                          // for password
                          SizedBox(height:5),

                          Row(
                            children: [
                              SizedBox(height:10,),
                              Text('   Password',style:Theme.of(context).textTheme.labelMedium),
                            ],
                          ),
                          Container(
                            width:310,
                            height:49,
                            margin:EdgeInsets.symmetric(vertical:10),
                            decoration:BoxDecoration(
                              borderRadius:BorderRadius.circular(15),
                              color:Colors.orange,
                            ),
                            child:Obx(() =>
                                TextField(
                                  keyboardType:TextInputType.visiblePassword,
                                  obscureText:authController.isPasswordVisible.value,
                                  controller:password,
                                  style:Theme.of(context).textTheme.bodySmall,
                                  cursorColor:Colors.black87,
                                  decoration:InputDecoration(
                                    border:OutlineInputBorder(
                                        borderRadius:BorderRadius.circular(15)
                                    ),
                                    hintText:'Password',
                                    suffixIcon:InkWell(
                                        onTap:(){
                                          authController.isPasswordVisible.toggle();
                                        },
                                        child: authController.isPasswordVisible.value?Icon(Icons.visibility_off_sharp,color:Colors.white) : Icon(Icons.remove_red_eye,color:Colors.white)
                                    ),
                                  ),
                                ),
                            )
                          ),
                          // for phone number
                          Row(
                            children: [
                              SizedBox(height:10,),
                              Text('   Phone',style:Theme.of(context).textTheme.labelMedium),
                            ],
                          ),
                          Container(
                            width:310,
                            height:49,
                            margin:EdgeInsets.symmetric(vertical:10),
                            decoration:BoxDecoration(
                              borderRadius:BorderRadius.circular(15),
                              color:Colors.orange,
                            ),
                            child:TextField(
                              keyboardType:TextInputType.phone,
                              obscureText:true,
                              controller:phone,
                              style:Theme.of(context).textTheme.bodySmall,
                              cursorColor:Colors.black87,
                              decoration:InputDecoration(
                                border:OutlineInputBorder(
                                    borderRadius:BorderRadius.circular(15)
                                ),
                                hintText:'Phone',
                                suffixIcon:Icon(Icons.call,color:Colors.white,),
                              ),
                            ),
                          ),
                          // for city
                          Row(
                            children: [
                              SizedBox(height:10,),
                              Text('   City',style:Theme.of(context).textTheme.labelMedium),
                            ],
                          ),
                          Container(
                            width:310,
                            height:49,
                            margin:EdgeInsets.symmetric(vertical:10),
                            decoration:BoxDecoration(
                              borderRadius:BorderRadius.circular(15),
                              color:Colors.orange,
                            ),
                            child:TextField(
                              keyboardType:TextInputType.text,
                              obscureText:true,
                              controller:city,
                              style:Theme.of(context).textTheme.bodySmall,
                              cursorColor:Colors.black87,
                              decoration:InputDecoration(
                                border:OutlineInputBorder(
                                    borderRadius:BorderRadius.circular(15)
                                ),
                                hintText:'City',
                                suffixIcon:Icon(Icons.location_on_outlined,color:Colors.white,),
                              ),
                            ),
                          ),
                              Container(
                                padding:const EdgeInsets.all(5),
                                margin:const EdgeInsets.symmetric(vertical:30),
                                width:310,
                                height:50,
                                decoration:BoxDecoration(
                                  borderRadius:BorderRadius.circular(15),
                                  color:Theme.of(context).colorScheme.primary,
                                ),
                                child:Center(child: InkWell(
                                    onTap:() async {
                                     if(name.text.isEmpty || email.text.isEmpty || password.text.isEmpty || phone.text.isEmpty || city.text.isEmpty){
                                       Get.snackbar("Error",'Please fill all required field',
                                           snackPosition:SnackPosition.BOTTOM,
                                           backgroundColor:Colors.red,
                                           colorText:Colors.white
                                       );
                                     }else  {
                                    UserCredential? userCredential  = await authController.SignUpMethod(name.text.trim(),email.text.trim(),phone.text.trim(),city.text.trim(),password.text.trim(),getDeviceTokenController.deviceToken!);
                                    if(userCredential !=null)
                                      {
                                        Get.snackbar("Verification email sent",'Please check your email',
                                            snackPosition:SnackPosition.BOTTOM,
                                            backgroundColor:Colors.red,
                                            colorText:Colors.white
                                        );
                                        Get.offAll(Login());
                                      }
                                     }

                                    },
                                    child:Text('Sign up ',style:Theme.of(context).textTheme.bodyMedium?.copyWith(color:Theme.of(context).colorScheme.onSurface)))),
                              ),
                          Row(children: [
                            Expanded(
                                flex:4,
                                child: Text("""       already have an account ?""",style:Theme.of(context).textTheme.labelMedium)),
                            Expanded(flex:2,child: InkWell(
                                onTap:(){
                                  Get.to(Login(),transition:Transition.fadeIn);
                                },
                                child: Text("""  Login""",style:Theme.of(context).textTheme.labelMedium?.copyWith(color:Theme.of(context).colorScheme.primary)))),
                          ],)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      },
    );
  }
}
