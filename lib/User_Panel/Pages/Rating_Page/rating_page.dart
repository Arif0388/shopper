
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desi_mart/Models/OrderModel.dart';
import 'package:desi_mart/Models/review_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({super.key, required this.orderModel});
final OrderModel orderModel;
  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  TextEditingController feedBackController = TextEditingController();
  double Rating = 0.0;
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        centerTitle:true,
        title:Text('Add Review'),
      ),
      body:Container(
        child:Column(
          crossAxisAlignment:CrossAxisAlignment.center,
          children: [
            SizedBox(height:20),
            Container(),
            Text('Add your rating and review',style:Theme.of(context).textTheme.labelLarge?.copyWith(color:Colors.lightGreenAccent)),
            SizedBox(height:20),
             RatingBar.builder(
             initialRating:1,
             minRating: 1,
             direction: Axis.horizontal,
             allowHalfRating: true,
             itemCount: 5,
             itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
             itemBuilder: (context, _) => Icon(
             Icons.star,
             color: Colors.amber,
             ),
             onRatingUpdate: (rating) {
              Rating = rating;
              setState(() {});
             },
             ),
            SizedBox(height:20),
            Text('FeedBack',style:Theme.of(context).textTheme.labelLarge?.copyWith(color:Colors.lightGreenAccent)),
            SizedBox(height:20),
            Container(
              width:Get.width/1.2,
              child: TextFormField(
                controller: feedBackController,
                decoration:InputDecoration(
                  label:Text('Share your Feedback'),
                   border:OutlineInputBorder(
                     borderRadius:BorderRadius.circular(10),
                   )
                ),
              ),
            ),
            SizedBox(height:20),
            ElevatedButton(
                style:ElevatedButton.styleFrom(backgroundColor:Colors.blueGrey),
                onPressed:()async{
                  EasyLoading.show(status:'Please Wait....');
                  String feedBack = feedBackController.text.trim();
               var reviewData = ReviewModel(
                 customerName:widget.orderModel.customerName,
                 customerId: widget.orderModel.customerId,
                 createdAt:DateTime.now().toString(),
                 customerDeviceToken:widget.orderModel.customerDeviceToken ,
                 customerPhone: widget.orderModel.customerPhone,
                 feedback:feedBack,
                 rating:Rating.toString(),
               );
               await FirebaseFirestore.instance.collection('products').doc(widget.orderModel.productId).collection('reviews').doc(user!.uid).set(reviewData.toJson());
               feedBackController.clear();
               EasyLoading.dismiss();
            }, child:Text('Submit',style:Theme.of(context).textTheme.labelLarge))
          ],
        ),
      ),
    );
  }
}
