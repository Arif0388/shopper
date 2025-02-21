import 'package:desi_mart/Controller/authController.dart';
import 'package:desi_mart/Pages/HomePage/widget/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    return Scaffold(
      drawer:Drawer(
        shadowColor:Colors.grey,
        backgroundColor:Theme.of(context).colorScheme.primary,
        child:drawer(),
      ),
      appBar:AppBar(
        backgroundColor:Theme.of(context).colorScheme.primary,
        title:Text('HomePage'),
        centerTitle:true,
        actions: [
          IconButton(onPressed: (){
          }, icon:Icon(Icons.add)),
        ],
      ),
    );
  }
}
