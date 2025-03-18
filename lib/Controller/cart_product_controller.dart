import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartProductController extends GetxController{
RxBool isLoading = false.obs;
final db = FirebaseFirestore.instance;
User? user = FirebaseAuth.instance.currentUser;
RxDouble totalPrice =0.0.obs;

@override
void onInit(){
  super.onInit();
 fetchCartProductPrice();
}

Future<void> cartProductDelete({required String currentUserId,required String productId})async{
  isLoading.value = true;
  await db.collection('cart').doc(currentUserId).collection('cartOrders').doc(productId).delete();
  isLoading.value = false;
}



Future<void> addProductToCart(String productName) async{
  isLoading.value = true;
Get.snackbar(
'Product Added',
'$productName has been added to your cart.',
snackPosition: SnackPosition.BOTTOM,
backgroundColor: Colors.green,
colorText: Colors.white,
duration: Duration(seconds: 2),
);
  isLoading.value = false;
}


Future<void> fetchCartProductPrice()async {
  var snapshot = await db.collection('cart').doc(user!.uid).collection('cartOrders').get();
  double sum = 0.0;
  for(var Data in snapshot.docs){
    var allData = Data.data();
    if(allData !=null && allData.containsKey('productTotalPrice')){
       sum = sum + (allData['productTotalPrice'] as num ).toDouble();
    }
  }
 totalPrice.value = sum;
}

}