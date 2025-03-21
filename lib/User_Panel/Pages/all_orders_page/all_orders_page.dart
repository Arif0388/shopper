
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desi_mart/Controller/cart_product_controller.dart';
import 'package:desi_mart/Models/OrderModel.dart';
import 'package:desi_mart/User_Panel/Pages/Rating_Page/rating_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllOrdersPagePage extends StatelessWidget {
  const AllOrdersPagePage({super.key});
  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;
    CartProductController cartProductController = Get.put(CartProductController());
    return Scaffold(
      appBar:AppBar(
        title:Text('All Orders',style:Theme.of(context).textTheme.labelLarge),
        centerTitle:true,
      ),
      body:Container(
        child:StreamBuilder(
          stream:db.collection('orders').doc(user!.uid).collection('confirmOrders').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CupertinoActivityIndicator()); // Show loading indicator while waiting for data
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}')); // Show error message if there's an error
            } else if (!snapshot.hasData || snapshot.data == null) {
              return Center(child: Text('No data available',style:TextStyle(color:Colors.red),)); // Show message if data is null or not available
            }else{
              return ListView.builder(
                shrinkWrap:true,
                physics:BouncingScrollPhysics(),
                itemCount:snapshot.data!.docs.length,
                itemBuilder:(context, index) {
                  var allData = snapshot.data.docs[index];
                  var orderData  = OrderModel(
                      productTotalPrice:allData['productTotalPrice'] ,
                      productImages:allData['productImages'] ,
                      productName: allData['productName'],
                      productId:allData['productId'],
                      productQuantity:allData['productQuantity'],
                      fullPrice:allData['fullPrice'],
                      status:allData['status'],
                    customerPhone:allData['customerPhone'] ,
                    customerDeviceToken: allData['customerDeviceToken'],
                    createdAt:allData['createdAt'] ,
                    customerId: allData['customerId'],
                    customerName:allData['customerName'] ,
                  );
                  cartProductController.fetchCartProductPrice();
                  return
                    Card(
                      elevation:20,
                      child: ListTile(
                        leading:CircleAvatar(
                          backgroundImage:NetworkImage(orderData.productImages![0]),
                          radius:50,
                        ),
                        title:Text(orderData.productName!,style:Theme.of(context).textTheme.labelLarge),
                        subtitle:Row(
                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Rs : ${orderData.productTotalPrice}',style:Theme.of(context).textTheme.labelMedium),
                            orderData.status==true?Text('Delivered',style:Theme.of(context).textTheme.labelSmall?.copyWith(color:Colors.lightGreenAccent)) : Text('Pending . . . .',style:Theme.of(context).textTheme.labelSmall?.copyWith(color:Colors.red)),
                            orderData.status==true?ElevatedButton(
                              style:ElevatedButton.styleFrom(
                                backgroundColor:Colors.blueGrey
                              ),
                                onPressed:(){
                                 Get.to(RatingPage(orderModel:orderData,));
                            }, child:Text('Review',style:Theme.of(context).textTheme.labelSmall?.copyWith(color:Colors.lightGreenAccent))) : SizedBox.shrink(),
                          ],
                        ),
                      ),
                    );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
