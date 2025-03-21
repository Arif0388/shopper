import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class RatingCalculateController extends GetxController{
 final String productId;
  RatingCalculateController({required this.productId});
  var db   = FirebaseFirestore.instance;
  RxDouble averageRating = 0.0.obs;
  void onInit(){
    super.onInit();
    calculateAverageRating();
  }

void calculateAverageRating()async{
    await db.collection('products').doc(productId).collection('reviews').snapshots().listen((snapshot){
     if(snapshot.docs.isNotEmpty){
       double totalRating = 0.0;
       int numberOfReview = 0;
       snapshot.docs.forEach((e){
         final ratingAsString = e['rating'] as String;
       final  rating = double.parse(ratingAsString);
         if(rating!=null){
           totalRating =totalRating + rating;
           numberOfReview++;
         }
        });
       if(numberOfReview !=0){
         averageRating.value = totalRating/numberOfReview;
       }else{
         averageRating.value = 0.0;
       }
     }

    });
}
  
}