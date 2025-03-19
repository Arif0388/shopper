
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desi_mart/Controller/cart_product_controller.dart';
import 'package:desi_mart/Models/CartModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/get_customerr_device_token.dart';
import '../../services/place_order.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;
    CartProductController cartProductController = Get.put(CartProductController());
    TextEditingController nameController  = TextEditingController();
    TextEditingController phoneController  = TextEditingController();
    TextEditingController cityController  = TextEditingController();
    TextEditingController addressController  = TextEditingController();
    return Scaffold(
      appBar:AppBar(
        title:Text('CheckOutPage',style:Theme.of(context).textTheme.labelLarge),
        centerTitle:true,
      ),
      body:Container(
        child:StreamBuilder(
          stream:db.collection('cart').doc(user!.uid).collection('cartOrders').snapshots(),
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
                      productId:allData['productId'],
                      productQuantity:allData['productQuantity'],
                      fullPrice:allData['fullPrice']
                  );
                  cartProductController.fetchCartProductPrice();
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
        ),
      ),
      bottomNavigationBar:Container(
        decoration:BoxDecoration(
          borderRadius:BorderRadius.only(topLeft:Radius.circular(10),topRight:Radius.circular(10)),
          color:Theme.of(context).colorScheme.primaryContainer,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment:MainAxisAlignment.spaceAround,
            children: [
              Obx(() =>
                  Text('Total : ${cartProductController.totalPrice.value}',style:Theme.of(context).textTheme.labelLarge),
              ),
              InkWell(
                onTap:(){
                  showModalBottomSheet(context:context, name:nameController, phone:phoneController, address:addressController, city:cityController);
                },
                child: Container(
                  width:100,
                  height:40,
                  decoration:BoxDecoration(
                      borderRadius:BorderRadius.circular(15),
                      color:Theme.of(context).colorScheme.onPrimaryContainer
                  ),
                  child:Center(child: Text('Confirm Order')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void showModalBottomSheet({required BuildContext context,required TextEditingController name,
    required TextEditingController phone,
    required TextEditingController address,
    required TextEditingController city}){
    Get.bottomSheet(
      Container(
        width:Get.width,
        height:Get.height/2.2,
        decoration:BoxDecoration(
          borderRadius:BorderRadius.circular(15),
          color:Theme.of(context).colorScheme.primaryContainer,
        ),
        child:SingleChildScrollView(
          child:Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  width:Get.width/1.2,
                  margin:EdgeInsets.symmetric(vertical:10),
                  child:TextFormField(
                    controller:name,
                    textInputAction:TextInputAction.next,
                    decoration:InputDecoration(
                        labelText:'Name',
                        labelStyle:Theme.of(context).textTheme.labelMedium,
                        suffixIcon:Icon(Icons.person,color:Theme.of(context).colorScheme.onPrimaryContainer,)
                    ),
                  ),
                ),
                Container(
                  width:Get.width/1.2,
                  margin:EdgeInsets.symmetric(vertical:10),
                  child:TextFormField(
                    controller:phone,
                    keyboardType:TextInputType.phone,
                    textInputAction:TextInputAction.next,
                    decoration:InputDecoration(
                        labelText:'Phone',
                        labelStyle:Theme.of(context).textTheme.labelMedium,
                        suffixIcon:Icon(Icons.phone,color:Theme.of(context).colorScheme.onPrimaryContainer)
                    ),
                  ),
                ),
                Container(
                  width:Get.width/1.2,
                  margin:EdgeInsets.symmetric(vertical:10),
                  child:TextFormField(
                    controller:address,
                    textInputAction:TextInputAction.next,
                    decoration:InputDecoration(
                        labelText:'Address',
                        labelStyle:Theme.of(context).textTheme.labelMedium,
                        suffixIcon:Icon(Icons.home,color:Theme.of(context).colorScheme.onPrimaryContainer)
                    ),
                  ),
                ),
                Container(
                  width:Get.width/1.2,
                  margin:EdgeInsets.symmetric(vertical:10),
                  child:TextFormField(
                    controller:city,
                    textInputAction:TextInputAction.next,
                    decoration:InputDecoration(
                        labelText:'City',
                        labelStyle:Theme.of(context).textTheme.labelMedium,
                        suffixIcon:Icon(Icons.location_city,color:Theme.of(context).colorScheme.onPrimaryContainer)
                    ),
                  ),
                ),
                SizedBox(height:20),
                ElevatedButton(
                    onPressed: ()async{
                      if(name.text !='' && phone.text !='' && city.text !='' && address.text !=''){
                       var userName = name.text.trim();
                       var userPhone = phone.text.trim();
                       var userAddress = address.text.trim();
                       var userCity = city.text.trim();
                     String customerToken =  await getCustomerDeviceToken();
                     placeOrder(customerDeviceToken:customerToken,context:context, customerName:userName, customerAddress:userAddress, customerCity:userCity, customerPhone: userPhone);
                      }else{
                        print('Please fill all required field');
                      }
                    }, child:Text('Place Order')
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

