import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desi_mart/Models/CategoryModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_card/image_card.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore db = FirebaseFirestore.instance;
     return FutureBuilder(
         future:db.collection('categories').get(),
         builder:(context, snapshot) {
          if(snapshot.hasError){
           return Center(child:Text('Error',style:Theme.of(context).textTheme.labelLarge));
          }else if(snapshot.data!.docs.isEmpty){
            return Center(child:Text('No Data Found!!',style:Theme.of(context).textTheme.labelLarge),);
          }else if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child:CupertinoActivityIndicator());
          }else{
            return Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height:155,
                    child: ListView.builder(
                      shrinkWrap:true,
                      scrollDirection:Axis.horizontal,
                      itemCount:snapshot.data!.docs.length,
                      itemBuilder:(context, index) {
                        var allCategory = CategoryModel(
                          categoryId:snapshot.data!.docs[index]['categoryId'],
                          categoryName:snapshot.data!.docs[index]['categoryName'],
                          categoryImg:snapshot.data!.docs[index]['categoryImg'],
                          updatedAt:snapshot.data!.docs[index]['updatedAt'],
                          createdAt:snapshot.data!.docs[index]['createdAt'],
                        );
                        return Card(
                          child: Container(
                            decoration:BoxDecoration(
                              borderRadius:BorderRadius.circular(15),
                              color:Colors.blueGrey,
                            ),
                            margin:EdgeInsets.all(5),
                            child:FillImageCard(
                              imageProvider:CachedNetworkImageProvider(allCategory.categoryImg! ?? ''),
                              title:Text(allCategory.categoryName! ?? '',style:Theme.of(context).textTheme.labelSmall),
                              width:120,
                              heightImage:90,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }
         },
     );

























 //       FutureBuilder(future:db.collection('categories').get(),
 //     builder:(context, snapshot) {
 //        if(snapshot.hasError){
 //          return Center(child: Text('Error'));
 //        }
 //
 //        if(snapshot.connectionState==ConnectionState.waiting){
 //          return Center(child:CupertinoActivityIndicator());
 //        }
 //
 //        if(snapshot.data!.docs.isEmpty){
 //          return Center(child: Text("No Category Found!"));
 //        }
 //
 //        if(snapshot.data!=null){
 //          return Container(
 //            child:ListView.builder(
 //              itemCount:snapshot.data!.docs.length,
 //              shrinkWrap:true,
 //            scrollDirection:Axis.horizontal,
 //            itemBuilder:(context, index) {
 //                CategoryModel categoryModel = CategoryModel(
 //                  categoryId:snapshot.data!.docs[index]['categoryId'],
 //                  categoryImg:snapshot.data!.docs[index]['categoryImg'],
 //                  categoryName:snapshot.data!.docs[index]['categoryName'],
 //                  createdAt:snapshot.data!.docs[index]['createdAt'],
 //                  updatedAt:snapshot.data!.docs[index]['updatedAt'],
 //                );
 //              return Row(
 //                children: [
 //                  Padding(
 //                    padding: const EdgeInsets.all(8.0),
 //                    child: Container(
 //                      width:100,
 //                      height:50,
 //                      color:Colors.red,
 //                      child:FillImageCard(
 //                        width:200,
 //                          heightImage:150,
 //                          imageProvider:CachedNetworkImageProvider(
 //                            categoryModel.categoryImg!
 //                          ),
 //                        title:Text('Category'),
 //                      ),
 //                    ),
 //                  ),
 //                ],
 //              );
 //            },
 //            ),
 //          );
 //        }
 //
 //        return Container();
 //     },
 // );
  }
}
