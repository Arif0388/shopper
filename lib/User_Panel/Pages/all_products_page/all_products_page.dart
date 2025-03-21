import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desi_mart/Config/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_card/image_card.dart';

import '../../../Models/ProductsModel.dart';
import '../Product_Details_Page/product_details_page.dart';

class AllProductsPage extends StatelessWidget {
  const AllProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore db = FirebaseFirestore.instance;
    return Scaffold(
      appBar:AppBar(
        centerTitle:true,
        title:Text('All Products'),
      ),
      body:FutureBuilder(
        future: db.collection('products').where('isSale',isEqualTo:false).get(),
        builder: (context,AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CupertinoActivityIndicator()); // Show loading indicator while waiting for data
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Show error message if there's an error
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Text('No data available'); // Show message if data is null or not available
          }else {
            return GridView.builder(
              gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,childAspectRatio:1.1),
              shrinkWrap:true,
              physics:BouncingScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var productData  = snapshot.data!.docs[index];
                var productSale = ProductModel(
                  productName:productData['productName'] ?? '',
                  productImages:productData['productImages'] ?? '',
                  isSale: productData['isSale'] ?? '',
                  productId: productData['productId'] ?? '',
                  fullPrice: productData['fullPrice']?? '',
                  categoryName:productData['categoryName'] ?? '' ,
                  productDescription: productData['productDescription'] ?? '',
                  categoryId: productData['categoryId'] ?? '',
                  salePrice:  productData['salePrice'] ?? '',
                  deliveryTime: productData['deliveryTime'] ?? '',
                  createdAt: productData['createdAt'] ?? '',
                  updatedAt: productData['updatedAt'] ?? '',
                );
                return Card(
                  child: InkWell(
                    onTap:(){
                      Get.to(ProductDetailsPage(productModel:productSale));
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      child: FillImageCard(
                        color:dContainerColor,
                        imageProvider: CachedNetworkImageProvider(productSale.productImages![0]),
                        title: Text(maxLines:1,productSale.productName!, style: Theme.of(context).textTheme.labelMedium?.copyWith(color:Colors.white)),
                        width:200,
                        heightImage:90,
                        footer:Row(
                          children: [
                            Text('Rs ${productSale.fullPrice!}',style:Theme.of(context).textTheme.labelMedium),
                            SizedBox(width:5,),
                            Text(productSale.salePrice!,style:TextStyle(decoration:TextDecoration.lineThrough,fontSize:12,color:Colors.red,fontFamily:'Poppins',fontWeight:FontWeight.w400,)),
                          ],
                        ),
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