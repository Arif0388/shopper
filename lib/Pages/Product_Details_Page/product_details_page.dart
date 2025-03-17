
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desi_mart/Controller/cart_product_controller.dart';
import 'package:desi_mart/Models/CartModel.dart';
import 'package:desi_mart/Pages/all_category_page/all_category_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Models/ProductsModel.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key, required this.productModel,});
  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    final User? user  = FirebaseAuth.instance.currentUser;
    CartProductController cartProductController = Get.put(CartProductController());
    return Scaffold(
      appBar:AppBar(
        centerTitle:true,
        title:Text('Product Details!',style:Theme.of(context).textTheme.headlineSmall),
      ),
      body:Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              margin:EdgeInsets.symmetric(horizontal:10),
              width:Get.width,
              height:Get.height/3,
              decoration:BoxDecoration(
                borderRadius:BorderRadius.circular(12),
                color:Theme.of(context).colorScheme.primaryContainer
              ),
              child:ClipRRect(
                  borderRadius:BorderRadius.circular(15),
                  child: CachedNetworkImage(fit:BoxFit.cover,imageUrl:productModel.productImages![0])
              ),
            ),
            SizedBox(height:10),
            Container(
              padding:EdgeInsets.all(5),
              decoration:BoxDecoration(
                borderRadius:BorderRadius.circular(10),
                color:Theme.of(context).colorScheme.primaryContainer
              ),
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children: [
                      Text(productModel.productName!,style:Theme.of(context).textTheme.bodyLarge),
                      IconButton(onPressed:(){}, icon:Icon(Icons.heart_broken_sharp))
                    ],
                  ),
                  productModel.isSale==true && productModel.salePrice !=''? Text('INR : ${productModel.salePrice}',style:Theme.of(context).textTheme.bodyLarge)
                  : Text('INR : ${productModel.fullPrice}',style:Theme.of(context).textTheme.bodyLarge),
                  SizedBox(height:10),
                  Text('Category : ${productModel.categoryName}',style:Theme.of(context).textTheme.bodyLarge),
                  SizedBox(height:10),
                  Text(productModel.productDescription!,style:Theme.of(context).textTheme.labelLarge),
                  SizedBox(height:10),
                  Row(
                    mainAxisAlignment:MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width:100,
                        height:50,
                        decoration:BoxDecoration(
                            borderRadius:BorderRadius.circular(15),
                            color:Theme.of(context).colorScheme.onPrimaryContainer
                        ),
                        child:Center(child: Text('Whatsapp',style:Theme.of(context).textTheme.labelLarge?.copyWith(color:Colors.greenAccent))),
                      ),
                          InkWell(
                            onTap:()async{
                              await checkProductExistence(Uid:user!.uid);
                            },
                            child: Container(
                              width:100,
                              height:50,
                              decoration:BoxDecoration(
                                  borderRadius:BorderRadius.circular(15),
                                  color:Theme.of(context).colorScheme.onPrimaryContainer
                              ),
                              child:Center(child:Text('Add to Cart',style:Theme.of(context).textTheme.labelLarge?.copyWith(color:Colors.tealAccent))),
                            ),
                          ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
// check product exist or not
Future<void> checkProductExistence({required String Uid})async{
    final int quantityIncrement = 1;
final db = FirebaseFirestore.instance;
   var documentReference  = db.collection('cart').doc(Uid).collection('cartOrders').doc(productModel.productId);
   DocumentSnapshot snapshot = await documentReference.get();

   if(snapshot.exists){
      int currentQuantity = snapshot['productQuantity'];
    int updatedQuantity = currentQuantity + quantityIncrement;

    double totalPrice = double.parse(productModel.isSale==true?productModel.salePrice! : productModel.fullPrice!) * updatedQuantity;
    await documentReference.update({
      'productQuantity':updatedQuantity,
      'productTotalPrice':totalPrice
    });
      Get.snackbar(
        'Product Already Exist',
        '${productModel.productName} have already exist in your cart.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
    }
   else{
     await db.collection('cart').doc(Uid).set({
       'Uid':Uid,
       'createdAt':DateTime.now(),
     });

     var cartModel = CartModel(
         productName:productModel.productName,
         productImages:productModel.productImages,
        isSale:productModel.isSale,
        productId:productModel.productId,
        fullPrice:productModel.fullPrice,
        categoryName:productModel.categoryName,
        createdAt:DateTime.now(),
        updatedAt:DateTime.now(),
        productDescription:productModel.productDescription,
        salePrice:productModel.salePrice,
        deliveryTime:productModel.deliveryTime,
        categoryId:productModel.categoryId,
       productQuantity:1,
       productTotalPrice:double.parse(productModel.isSale==true?productModel.salePrice! : productModel.fullPrice!),
     );

     await documentReference.set(cartModel.toJson());
     Get.snackbar(
       'Product Added',
       '${productModel.productName} has been added to your cart.',
       snackPosition: SnackPosition.BOTTOM,
       backgroundColor: Colors.green,
       colorText: Colors.white,
       duration: Duration(seconds: 2),
     );
   }


}


}
