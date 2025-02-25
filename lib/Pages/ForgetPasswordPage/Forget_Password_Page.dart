
import 'package:desi_mart/Controller/forget_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Config/AssetsPath.dart';
class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage ({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
     ForgetPasswordController forgetPasswordController = Get.put(ForgetPasswordController());
    return SafeArea(
      child: Scaffold(
        backgroundColor:Theme.of(context).colorScheme.primary,
        body:Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height:70,),
                Center(child: Text("Forget Password",style:Theme.of(context).textTheme.headlineLarge)),
                SizedBox(height:20),
                Expanded(flex:0,child: Image.asset(ImagesPath.appLogo,width:200,)),
                SizedBox(height:70,),
                Container(
                  padding:EdgeInsets.only(top:10),
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
                        InkWell(
                          onTap:(){
                            String userEmail = email.text.trim();
                            if(userEmail.isNotEmpty)
                              {
                                forgetPasswordController.forgetPassword(userEmail);
                              }
                          },
                          child: Container(
                            padding:const EdgeInsets.all(5),
                            margin:const EdgeInsets.symmetric(vertical:50),
                            width:310,
                            height:50,
                            decoration:BoxDecoration(
                              borderRadius:BorderRadius.circular(15),
                              color:Theme.of(context).colorScheme.primary,
                            ),
                            child: Center(child: Text('Forget Password',style:Theme.of(context).textTheme.bodyMedium?.copyWith(color:Theme.of(context).colorScheme.onSurface)))
                          ),
                        ),
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
