import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desi_mart/Controller/get_user_data_controller.dart';
import 'package:desi_mart/Controller/sign_up_controller.dart';
import 'package:desi_mart/Models/ProductsModel.dart';
import 'package:desi_mart/Pages/HomePage/widget/banner_widget.dart';
import 'package:desi_mart/Pages/HomePage/widget/category_widget.dart';
import 'package:desi_mart/Pages/HomePage/widget/drawer_widget.dart';
import 'package:desi_mart/Pages/HomePage/widget/heading_widget.dart';
import 'package:desi_mart/Pages/HomePage/widget/sale_widget.dart';
import 'package:desi_mart/Pages/WelcomePage/WelcomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../Config/Colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore db = FirebaseFirestore.instance;
    GetUserDataController getUserDataController = Get.put(GetUserDataController());
    return Scaffold(
       backgroundColor:ownColor2,
      // backgroundColor:Theme.of(context).colorScheme.primaryContainer,
      drawer:Drawer(
        backgroundColor:ownColor2,
        child:drawer(),
      ),
      appBar:AppBar(
        backgroundColor:ownColor2,
        title:Text('HomePage'),
        centerTitle:true,
        elevation:50,
      ),
      body:SingleChildScrollView(
        scrollDirection:Axis.vertical,
        child: Column(
          children: [
            SizedBox(height:5),
            BannerWidget(),
            HeadingWidget(titleHeading: 'Categories', SubtitleHeading: 'According to your choice', onTap: () {  }, buttonText: 'See More>',),
            CategoryWidget(),
            HeadingWidget(titleHeading: 'Flash Sale', SubtitleHeading: 'According to your choice', onTap: () {  }, buttonText: 'See More>',),
            SaleWidget(),
        ],
        ),
      ),
    );
  }
}
