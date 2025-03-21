import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desi_mart/Models/OrderModel.dart';
import 'package:desi_mart/services/generate_order_id.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void placeOrder({required BuildContext context,
  required customerName,
  required customerAddress,
  required customerCity,
  required customerPhone, required customerDeviceToken})async{
 final user = FirebaseAuth.instance.currentUser;
 if(user!=null){
 try{
   QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('cart').doc(user.uid).collection('cartOrders').get();

   List<QueryDocumentSnapshot> documents = querySnapshot.docs;

   for(var doc in documents){
     Map<String,dynamic>? data  = doc.data() as  Map<String,dynamic>;
     String orderId = generateOrderId();
     OrderModel orderModel = OrderModel(
       productName:data['productName'],
       productImages:data['productImages'],
       productQuantity: data['productQuantity'],
       productTotalPrice: data['productTotalPrice'],
       categoryId: data['categoryId'],
       deliveryTime: data['deliveryTime'],
       salePrice:data['salePrice'] ,
       productDescription: data['productDescription'],
       updatedAt: data['updatedAt'],
       createdAt: data['createdAt'],
       categoryName: data['categoryName'],
       fullPrice: data['fullPrice'],
       productId: data['productId'],
       isSale: data['isSale'],
       customerAddress:customerAddress,
       customerId:user.uid,
       customerName: customerName,
         customerPhone:customerPhone,
       status:false,
       customerDeviceToken:customerDeviceToken
     );
     for(var i=0; i<documents.length; i++)
     {
       await FirebaseFirestore.instance.collection('orders').doc(user.uid).set({
         'uId':user.uid,
         'customerName':customerName,
         'customerAddress':customerAddress,
         'customerPhone':customerPhone,
         'customerCity':customerCity,
         'customerDeviceToken':customerDeviceToken,
         'orderStatus':false,
         'createdAt':DateTime.now(),
       });
  //upload orders
       await FirebaseFirestore.instance.collection('orders').doc(user.uid).collection('confirmOrders').doc(orderId).set(orderModel.toJson());
       //delete cart
       await FirebaseFirestore.instance.collection('cart').doc(user.uid).collection('cartOrders').doc(orderModel.productId).delete().then((value){
         print('Delete cart products ${orderModel.productId}');
          });
     }

   }

 }catch(e){
   print('Error :$e');
    }
 }
 Get.snackbar(
   'Order Confirm',
   'order is Confirmed',
   snackPosition: SnackPosition.TOP,
   backgroundColor: Colors.green,
   colorText: Colors.white,
   duration: Duration(seconds: 2),
 );
}