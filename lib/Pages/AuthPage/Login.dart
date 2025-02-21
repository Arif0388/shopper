
import 'package:desi_mart/Controller/authController.dart';
import 'package:desi_mart/Pages/AuthPage/Signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
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
                            controller:authController.email,
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
                          child:TextFormField(
                            obscureText:true,
                           controller:authController.password,
                            style:Theme.of(context).textTheme.bodySmall,
                            cursorColor:Colors.black87,
                            decoration:InputDecoration(
                              border:OutlineInputBorder(
                                  borderRadius:BorderRadius.circular(15)
                              ),
                              hintText:'Password',
                              suffixIcon:Icon(Icons.password,color:Colors.white,),
                            ),
                          ),
                        ),
                        Obx(() =>
                            Container(
                              padding:const EdgeInsets.all(5),
                              margin:const EdgeInsets.symmetric(vertical:65),
                              width:310,
                              height:50,
                              decoration:BoxDecoration(
                                borderRadius:BorderRadius.circular(15),
                                color:Theme.of(context).colorScheme.primary,
                              ),
                              child:InkWell(
                                  onTap:(){
                                    authController.login();
                                  },
                                  child:authController.isLoading.value? Center(child: CircularProgressIndicator(color:Colors.white,)) : Center(child: Text('Login ',style:Theme.of(context).textTheme.bodyMedium?.copyWith(color:Theme.of(context).colorScheme.onSurface)))),
                            ),
                        ),
                        Row(children: [
                          Expanded(flex:2,  child: Text("""       Don't have account ?""",style:Theme.of(context).textTheme.labelMedium)),
                          Expanded(flex:2,  child: InkWell(
                              onTap:(){
                                Get.to(SignUp(),transition:Transition.fadeIn);
                              },
                              child: Text("""  Create account""",style:Theme.of(context).textTheme.labelMedium?.copyWith(color:Theme.of(context).colorScheme.primary)))),
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
