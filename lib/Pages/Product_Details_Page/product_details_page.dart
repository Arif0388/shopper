
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desi_mart/Models/CartModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key, required this.productName, required this.productImage,required this.productDesc, required this.categoryName, required this.productSalePrice, required this.productIsSale, required this.productFullPrice, required this.productId, required this.categoryId});
 final String productName;
 final String productImage;
 final String productSalePrice;
 final String productFullPrice;
 final bool productIsSale;
 final String productDesc;
 final String categoryName;
 final String categoryId;
 final String productId;
  @override
  Widget build(BuildContext context) {
    final User? user  = FirebaseAuth.instance.currentUser;
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
                  child: CachedNetworkImage(fit:BoxFit.cover,imageUrl:productImage)),
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
                      Text(productName,style:Theme.of(context).textTheme.bodyLarge),
                      IconButton(onPressed:(){}, icon:Icon(Icons.heart_broken_sharp))
                    ],
                  ),
                  productIsSale==true && productSalePrice !=''? Text('INR : $productSalePrice',style:Theme.of(context).textTheme.bodyLarge)
                  : Text('INR : $productFullPrice',style:Theme.of(context).textTheme.bodyLarge),
                  SizedBox(height:10),
                  Text('Category : $categoryName',style:Theme.of(context).textTheme.bodyLarge),
                  SizedBox(height:10),
                  Text(productDesc,style:Theme.of(context).textTheme.labelLarge),
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
                          child:Center(child: Text('Add to Cart',style:Theme.of(context).textTheme.labelLarge?.copyWith(color:Colors.tealAccent))),
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
   var documentReference  = db.collection('cart').doc(Uid).collection('cartOrders').doc(productId.toString());
   DocumentSnapshot snapshot = await documentReference.get();

   if(snapshot.exists){
    int currentQuantity = snapshot['productQuantity'];
    int updatedQuantity = currentQuantity + quantityIncrement;
    double totalPrice = double.parse(productFullPrice) * updatedQuantity;
    await documentReference.update({
      'productQuantity':updatedQuantity,
      'fullPrice':totalPrice
    });
    print('Product Exist');
    }else{
     await db.collection('cart').doc(Uid).set({
       'Uid':Uid,
       'createdAt':DateTime.now(),
     });

     var cartModel = CartModel(
         productName:productName,
         productImages:productImage[0] as List,
        isSale:productIsSale,
        productId:productId,
        fullPrice:productFullPrice,
        categoryName:categoryName,
        createdAt:DateTime.now(),
       updatedAt:DateTime.now(),
        productDescription:productDesc,
        salePrice:productSalePrice,
       deliveryTime:'',
        categoryId:categoryId,
       productQuantity:1,
       productTotalPrice:double.parse(productFullPrice),
     );

     await documentReference.set(cartModel.toJson());
     print('Product Added');
   }


}


}
