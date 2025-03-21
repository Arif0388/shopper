
import 'package:desi_mart/Controller/get_user_data_controller.dart';
import 'package:desi_mart/Controller/sign_in_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../AdminPage/adminPage.dart';
import '../ForgetPasswordPage/Forget_Password_Page.dart';
import '../HomePage/HomePage.dart';
import 'Signup.dart';
class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    SignInController signInController  = Get.put(SignInController());
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    GetUserDataController getUserDataController = Get.put(GetUserDataController());
    return SafeArea(
      child: Scaffold(
        backgroundColor:Theme.of(context).colorScheme.primary,
        body:Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height:70,),
                Center(child: Text("Login",style:Theme.of(context).textTheme.headlineLarge)),
                SizedBox(height:70,),
                Container(
                  padding:EdgeInsets.only(top:10),
                  width:350,
                  height:435,
                  decoration:BoxDecoration(
                    borderRadius:BorderRadius.circular(16),
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child:Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
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
                          child:TextFormField(
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
                              TextFormField(
                                obscureText:signInController.isPasswordVisible.value,
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
                                        signInController.isPasswordVisible.toggle();
                                      },
                                      child: signInController.isPasswordVisible.value? Icon(Icons.visibility_off_sharp,color:Colors.white,) : Icon(Icons.remove_red_eye,color:Colors.white,)
                                  ),
                                ),
                              ),
                          )
                        ),
                        InkWell(
                          onTap:(){
                            Get.to(ForgetPasswordPage());
                          },
                          child: Container(
                            margin:EdgeInsets.symmetric(vertical:5),
                            alignment:Alignment.centerRight,
                            child:Text('Forget Password?',style:Theme.of(context).textTheme.labelLarge),
                          ),
                        ),
                            Container(
                              padding:const EdgeInsets.all(5),
                              margin:const EdgeInsets.symmetric(vertical:50),
                              width:310,
                              height:50,
                              decoration:BoxDecoration(
                                borderRadius:BorderRadius.circular(15),
                                color:Theme.of(context).colorScheme.primary,
                              ),
                              child:InkWell(
                                  onTap:() async {
                                  String userEmail = email.text;
                                  String userPassword = password.text;
                                  if(userEmail.isEmpty|| userPassword.isEmpty)
                                    {
                                      Get.snackbar("Error",'Please fill all required field',
                                          snackPosition:SnackPosition.BOTTOM,
                                          backgroundColor:Colors.red,
                                          colorText:Colors.white
                                      );
                                    }else{
                                       UserCredential? userCredential = await signInController.SignInMethod(userEmail, userPassword);
                                       var userData = await getUserDataController.getUserData(userCredential!.user!.uid);

                                       if(userCredential!=null)
                                         {
                                           if(userCredential.user!.emailVerified)
                                             {
                                               if(userData[0]['isAdmin'] ==true){
                                                 Get.snackbar("Success login to Admin",'Login successfully to Admin',
                                                     snackPosition:SnackPosition.BOTTOM,
                                                     backgroundColor:Colors.teal,
                                                     colorText:Colors.white
                                                 );
                                                 Get.offAll(AdminPage());
                                               }else{
                                                 Get.offAll(HomePage());
                                                 Get.snackbar("Success login to User",'Login successfully to User',
                                                     snackPosition:SnackPosition.BOTTOM,
                                                     backgroundColor:Colors.teal,
                                                     colorText:Colors.white
                                                 );
                                               }

                                             }else{
                                             Get.snackbar("Error",'Please verify your email before login',
                                                 snackPosition:SnackPosition.BOTTOM,
                                                 backgroundColor:Colors.red,
                                                 colorText:Colors.white
                                             );
                                           }
                                         }else  {
                                         Get.snackbar("Error",'Please try again',
                                             snackPosition:SnackPosition.BOTTOM,
                                             backgroundColor:Colors.red,
                                             colorText:Colors.white
                                         );
                                       }
                                  }
                                  },
                                  child:Center(child: Text('Login ',style:Theme.of(context).textTheme.bodyMedium?.copyWith(color:Theme.of(context).colorScheme.onSurface)))),
                            ),
                        Row(children: [
                          Expanded(flex:3,  child: Text("""       Don't have an account ?""",style:Theme.of(context).textTheme.labelMedium)),
                          Expanded(flex:2,  child: InkWell(
                              onTap:(){
                                Get.to(SignUp(),transition:Transition.fadeIn);
                              },
                              child: Text("""  Create an account""",style:Theme.of(context).textTheme.labelMedium?.copyWith(color:Theme.of(context).colorScheme.primary)))),
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
  }
}
