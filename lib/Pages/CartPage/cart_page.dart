
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desi_mart/Controller/cart_product_controller.dart';
import 'package:desi_mart/Models/CartModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;
    CartProductController cartProductController = Get.put(CartProductController());
    return Scaffold(
      appBar:AppBar(
        title:Text('Cart Page',style:Theme.of(context).textTheme.labelLarge),
        centerTitle:true,
      ),
      body:Container(
        child: Obx(() => cartProductController.isLoading.value? Center(child: CupertinoActivityIndicator()) : FutureBuilder(
          future:db.collection('cart').doc(user!.uid).collection('cartOrders').get(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CupertinoActivityIndicator()); // Show loading indicator while waiting for data
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}'); // Show error message if there's an error
            } else if (!snapshot.hasData || snapshot.data == null) {
              return Text('No data available'); // Show message if data is null or not available
            }else{
              return ListView.builder(
                   shrinkWrap:true,
                   physics:BouncingScrollPhysics(),
                   itemCount:snapshot.data!.docs.length,
                   itemBuilder:(context, index) {
                     var allData = snapshot.data.docs[index];
                     var cartData  = CartModel(
                         productTotalPrice:allData['productTotalPrice'] ,
                         productImages:allData['productImages'] ,
                         productName: allData['productName'],
                         productId:allData['productId']
                     );
                     return
                       Card(
                         elevation:5,
                         child: ListTile(
                           leading:CircleAvatar(
                             backgroundImage:NetworkImage(cartData.productImages![0]),
                             radius:50,
                           ),
                           title:Text(cartData.productName!,style:Theme.of(context).textTheme.labelLarge),
                           subtitle:Row(
                             mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                             children: [
                               Text('Rs : ${cartData.productTotalPrice}',style:Theme.of(context).textTheme.labelMedium),
                               CircleAvatar(
                                 child:Text('+'),
                               ),
                               CircleAvatar(
                                 child:Text('-'),
                               ),
                               IconButton(onPressed:(){
                                 cartProductController.cartProductDelete(currentUserId:user.uid, productId:cartData.productId!);
                               }, icon:Icon(Icons.delete,color:Theme.of(context).colorScheme.onPrimaryContainer,))
                             ],
                           ),
                         ),
                       );
                   },
                 );
            }
          },
        ),)
      ),
      bottomNavigationBar:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment:MainAxisAlignment.spaceEvenly,
          children: [
            Text('Total : 1200',style:Theme.of(context).textTheme.labelLarge),
            Container(
              width:100,
              height:50,
              decoration:BoxDecoration(
                borderRadius:BorderRadius.circular(15),
                color:Theme.of(context).colorScheme.primaryContainer
              ),
              child:Center(child: Text('Checkout')),
            ),
          ],
        ),
      ),
    );
  }
}
