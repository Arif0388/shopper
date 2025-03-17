import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desi_mart/Models/ProductsModel.dart';
import 'package:desi_mart/Pages/Product_Details_Page/product_details_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_card/image_card.dart';

class SingleCategoryProductsPage extends StatelessWidget {
  const SingleCategoryProductsPage ({super.key, required this.categoryId,});
  final String categoryId;
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore db = FirebaseFirestore.instance;
    return Scaffold(
      appBar:AppBar(
        elevation:10,
        centerTitle:true,
        title:Text('Products'),
      ),
      body:FutureBuilder(
        future:db.collection('products').where('categoryId',isEqualTo:categoryId).get(),
        builder:(context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CupertinoActivityIndicator()); // Show loading indicator while waiting for data
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Show error message if there's an error
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Text('No data available'); // Show message if data is null or not available
          }else{
            return GridView.builder(
              gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,childAspectRatio:1),
              shrinkWrap:true,
              physics:BouncingScrollPhysics(),
              itemCount:snapshot.data!.docs.length,
              itemBuilder:(context, index) {
                var allData = snapshot.data!.docs[index];
                var allProducts =  ProductModel(
                  categoryId:allData['categoryId'],
                    salePrice:allData['salePrice'] ,
                  productDescription: allData['productDescription'],
                  updatedAt: allData['updatedAt'],
                      createdAt: allData['createdAt'],
                   categoryName:allData['categoryName'] ,
                  fullPrice:allData['fullPrice'] ,
                   productId:allData['productId'] ,
                  isSale: allData['isSale'],
                  productImages: allData['productImages'],
                  productName: allData['productName'],
                );
                return Card(
                  child: InkWell(
                    onTap:(){
                      Get.to(ProductDetailsPage(productModel:allProducts));
                    },
                    child: Container(
                      margin:EdgeInsets.all(5),
                      child:FillImageCard(
                        color:Colors.white10,
                        borderRadius:5,
                        imageProvider:CachedNetworkImageProvider(allProducts.productImages![0]),
                        title:Text(allProducts.productName ?? '',style:Theme.of(context).textTheme.labelMedium?.copyWith(color:Colors.white)),
                        width:200,
                        heightImage:100,
                        description:Text(overflow:TextOverflow.ellipsis,allProducts.productDescription ?? '',style:Theme.of(context).textTheme.labelMedium),
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
