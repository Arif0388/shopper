import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_card/image_card.dart';

import '../../../Models/ProductsModel.dart';

class SaleWidget extends StatelessWidget {
  const SaleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore db = FirebaseFirestore.instance;
    return FutureBuilder(
      future: db.collection('products').where('isSale',isEqualTo:true).get(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error', style: Theme
              .of(context)
              .textTheme
              .labelLarge));
        } else if (snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No Data Found!!', style: Theme
              .of(context)
              .textTheme
              .labelLarge),);
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CupertinoActivityIndicator());
        } else {
          return Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 175,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var productData  = snapshot.data!.docs[index];
                      var productSale = ProductModel(
                          productName:productData['productName'],
                        productImages:productData['productImages'],
                        isSale: productData['isSale'],
                        productId: productData['productId'],
                        fullPrice: productData['fullPrice'],
                        categoryName:productData['categoryName'] ,
                        productDescription: productData['productDescription'],
                        categoryId: productData['categoryId'],
                        salePrice:  productData['salePrice'],
                        deliveryTime: productData['deliveryTime'],
                        createdAt: productData['createdAt'],
                        updatedAt: productData['updatedAt'],
                      );
                      return Card(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.blueGrey,
                          ),
                          margin: EdgeInsets.all(5),
                          child: FillImageCard(
                            imageProvider: CachedNetworkImageProvider(productSale.productImages![0]),
                            title: Text(maxLines:1,productSale.productName!, style: Theme
                                .of(context)
                                .textTheme
                                .labelSmall),
                            width: 120,
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
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}