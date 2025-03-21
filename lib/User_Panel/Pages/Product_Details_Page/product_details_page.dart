
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desi_mart/Models/CartModel.dart';
import 'package:desi_mart/Models/review_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Controller/rating_controller.dart';
import '../../../Models/ProductsModel.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key, required this.productModel,});
  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    final User? user  = FirebaseAuth.instance.currentUser;
    RatingCalculateController ratingCalculateController = Get.put(RatingCalculateController(productId:productModel.productId!));
    final db  = FirebaseFirestore.instance;
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
                 Obx( () => RatingBar.builder(
                   itemSize:20,
                   initialRating:ratingCalculateController.averageRating.toDouble(),
                   direction: Axis.horizontal,
                   allowHalfRating: true,
                   itemCount: 5,
                   itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                   itemBuilder: (context, _) => Icon(
                     Icons.star,
                     color: Colors.amber,
                   ), onRatingUpdate: (double value) {  },
                 )),
                  SizedBox(height:10),
                 Obx(() => Text('AVG : ${ratingCalculateController.averageRating}',style:Theme.of(context).textTheme.bodyLarge),),
                  SizedBox(height:10),
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
                      ElevatedButton(
                          style:ElevatedButton.styleFrom(
                              backgroundColor:Colors.blueGrey,
                          ),
                          onPressed:(){
                            sendMessageOnWhatsapp(productModel:productModel);
                          }, child:Text('Whatsapp',style:Theme.of(context).textTheme.labelSmall?.copyWith(color:Colors.lightGreenAccent))
                      ),
                          ElevatedButton(
                              style:ElevatedButton.styleFrom(
                                backgroundColor:Colors.blueGrey,
                              ),
                              onPressed:()async{
                                await checkProductExistence(Uid:user!.uid);
                              }, child:Text('Add to Cart',style:Theme.of(context).textTheme.labelSmall?.copyWith(color:Colors.lightGreenAccent))
                          ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height:20),
            FutureBuilder(
              future:db.collection('products').doc(productModel.productId).collection('reviews').get(),
              builder:(context, snapshot) {
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
                      var data = snapshot.data!.docs[index];
                      var reviewData = ReviewModel(
                        customerName:data['customerName'],
                        rating: data['rating'],
                        feedback: data['feedback']
                      );
                        return Card(
                          elevation:10,
                          child: ListTile(
                            leading:CircleAvatar(
                              child:Text(reviewData.customerName![0]),
                            ),
                            title:Text(reviewData.customerName!),
                            subtitle:Text(reviewData.feedback!),
                            trailing:Text('R :⭐ ${reviewData.rating!}'),
                          ),
                        );
                      },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
  Future<void> sendMessageOnWhatsapp({required ProductModel productModel})async{
    String number = '+919801298785';
    String message = 'App Name : Shopper \n description : I want to know about this product \n Product Name: ${productModel.productName} \n Product Id: ${productModel.productId} \n Product Price: ${productModel.fullPrice}';
    String url = 'https://wa.me/$number?text=${Uri.encodeComponent(message)}';

    if(await canLaunchUrl(Uri.parse(url))){
      await launchUrl(Uri.parse(url));
    }
    else{
       throw 'Could not launch ${url}';
    }

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
