import 'package:desi_mart/Controller/get_user_data_controller.dart';
import 'package:desi_mart/Controller/sign_up_controller.dart';
import 'package:desi_mart/Pages/HomePage/widget/banner_widget.dart';
import 'package:desi_mart/Pages/HomePage/widget/drawer_widget.dart';
import 'package:desi_mart/Pages/HomePage/widget/heading_widget.dart';
import 'package:desi_mart/Pages/WelcomePage/WelcomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    GetUserDataController getUserDataController = Get.put(GetUserDataController());
    return Scaffold(
      backgroundColor:Theme.of(context).colorScheme.primaryContainer,
      drawer:Drawer(
        backgroundColor:Theme.of(context).colorScheme.primary,
        child:drawer(),
      ),
      appBar:AppBar(
        backgroundColor:Theme.of(context).colorScheme.primary,
        title:Text('HomePage'),
        centerTitle:true,
      ),
      body:Column(
        children: [
          SizedBox(height:5),
          BannerWidget(),
          HeadingWidget(titleHeading: 'Categories', SubtitleHeading: 'According to your choice', onTap: () {  }, buttonText: 'See More>',),
      ],
      ),
    );
  }
}
