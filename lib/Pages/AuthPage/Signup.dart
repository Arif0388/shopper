import 'package:desi_mart/ApiService/ApiService.dart';
import 'package:desi_mart/Config/AssetsPath.dart';
import 'package:desi_mart/Config/Page_Routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
class SignUp extends StatefulWidget {
    const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
   TextEditingController email = TextEditingController();
   TextEditingController password = TextEditingController();
      bool  isLoading =false;

  @override
  Widget build(BuildContext context) {
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
                SizedBox(height:15),
                Center(child: Text("""To Get more advantages signup you account by filling 
                 
                                 some information""",style:Theme.of(context).textTheme.bodySmall)),
                SizedBox(height:70,),
                Container(
                  padding:EdgeInsets.only(top:15),
                  width:350,
                  height:520,
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
                          child:TextField(
                            obscureText:true,
                            controller:password,
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
                        Container(
                          padding:const EdgeInsets.all(5),
                          margin:const EdgeInsets.symmetric(vertical:65),
                          width:310,
                          height:50,
                          decoration:BoxDecoration(
                            borderRadius:BorderRadius.circular(15),
                            color:Theme.of(context).colorScheme.primary,
                          ),
                          child:Center(child: InkWell(
                            onTap:(){
                              ApiService.signUp(email.text.toString(),password.text.toString());
                              print('Email :$email');
                              print('Password :$password');
                                    context.go('/homePage');
                            },
                              child:  isLoading ? CircularProgressIndicator(color:Colors.yellow,) : Text('Sign up ',style:Theme.of(context).textTheme.bodyMedium?.copyWith(color:Theme.of(context).colorScheme.onSurface)))),
                        ),
                        Row(children: [
                          Expanded(child: Text("""       Don't have account ?""",style:Theme.of(context).textTheme.labelMedium)),
                          Expanded(child: Text("""  Create account""",style:Theme.of(context).textTheme.labelMedium?.copyWith(color:Theme.of(context).colorScheme.primary))),
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
