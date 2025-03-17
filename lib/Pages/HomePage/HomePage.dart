import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desi_mart/Pages/CartPage/cart_page.dart';
import 'package:desi_mart/Pages/HomePage/widget/all_products_widget.dart';
import 'package:desi_mart/Pages/HomePage/widget/banner_widget.dart';
import 'package:desi_mart/Pages/HomePage/widget/category_widget.dart';
import 'package:desi_mart/Pages/HomePage/widget/drawer_widget.dart';
import 'package:desi_mart/Pages/HomePage/widget/heading_widget.dart';
import 'package:desi_mart/Pages/HomePage/widget/sale_widget.dart';
import 'package:desi_mart/Pages/all_category_page/all_category_page.dart';
import 'package:desi_mart/Pages/all_products_page/all_products_page.dart';
import 'package:desi_mart/Pages/all_sale_page/all-sale_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore db = FirebaseFirestore.instance;
    return Scaffold(
      drawer:Drawer(
        child:drawer(),
      ),
      appBar:AppBar(
        title:Text('Shopper',style:TextStyle(shadows:[
          Shadow(
            color:Colors.greenAccent,
            blurRadius:20
          ),
        ]),),
        centerTitle:true,
        actions: [
          IconButton(onPressed:(){
            Get.to(CartPage());
          }, icon:Icon(Icons.shopping_cart_rounded))
        ],
      ),
      body:SingleChildScrollView(
        scrollDirection:Axis.vertical,
        child: Column(
          children: [
            SizedBox(height:5),
            BannerWidget(),
            HeadingWidget(
              titleHeading: 'Categories',
              SubtitleHeading: 'According to your choice',
              onTap: () {
                Get.to(AllCategoryPage());
              },
              buttonText: 'See More>',
            ),
            CategoryWidget(),
            HeadingWidget(
              titleHeading: 'Flash Sale',
              SubtitleHeading: 'According to your choice',
              onTap: (){
                Get.to(AllSalePage());
              },
              buttonText: 'See More>',
            ),
            SaleWidget(),
            HeadingWidget(
              titleHeading: 'All Products',
              SubtitleHeading: 'According to your choice',
              onTap: (){
                Get.to(AllProductsPage());
              },
              buttonText: 'See More>',
            ),
            AllProductsWidget(),
        ],
        ),
      ),
    );
  }
}
