import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desi_mart/Config/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

import '../../../Models/CategoryModel.dart';
import '../single_category_products_page/single_category_products_page.dart';

class AllCategoryPage extends StatelessWidget {
  const AllCategoryPage({super.key,});
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore db = FirebaseFirestore.instance;
    return Scaffold(
      appBar:AppBar(
        elevation:10,
        centerTitle:true,
        title:Text('All Category'),
      ),
      body:FutureBuilder(
        future:db.collection('categories').get(),
        builder:(context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CupertinoActivityIndicator()); // Show loading indicator while waiting for data
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Show error message if there's an error
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Text('No data available'); // Show message if data is null or not available
          }else{
            return GridView.builder(
              gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,childAspectRatio:1.2,mainAxisSpacing:5),
              shrinkWrap:true,
              physics:BouncingScrollPhysics(),
              itemCount:snapshot.data!.docs.length,
              itemBuilder:(context, index) {
                var allCategory = CategoryModel(
                  categoryId:snapshot.data!.docs[index]['categoryId'] ?? '',
                  categoryName:snapshot.data!.docs[index]['categoryName'] ?? '',
                  categoryImg:snapshot.data!.docs[index]['categoryImg'] ?? '',
                  updatedAt:snapshot.data!.docs[index]['updatedAt'] ?? '',
                  createdAt:snapshot.data!.docs[index]['createdAt'] ?? '',
                );
                return InkWell(
                  onTap:()=>Get.to(
                      SingleCategoryProductsPage(
                        categoryId:allCategory.categoryId ?? '',
                      )
                  ),
                  child: Card(
                    child: Container(
                      margin:EdgeInsets.all(5),
                      child:FillImageCard(
                        color:dContainerColor,
                        imageProvider:CachedNetworkImageProvider(allCategory.categoryImg! ?? ''),
                        title:Text(allCategory.categoryName! ?? '',style:Theme.of(context).textTheme.labelMedium?.copyWith(color:Colors.white)),
                        width:200,
                        heightImage:90,
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
