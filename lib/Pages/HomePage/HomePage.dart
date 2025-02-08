import 'dart:core';
import 'dart:core';

import 'package:desi_mart/ApiService/ApiService.dart';
import 'package:desi_mart/Config/AssetsPath.dart';
import 'package:desi_mart/Config/Page_Routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var category = [
      {'id':'1','name':'Tomato','image':'url'},
      {'id':'1','name':'Potato','image':'url'},
      {'id':'1','name':'Tomato','image':'url'},
      {'id':'1','name':'Potato','image':'url'},
      {'id':'1','name':'Tomato','image':'url'},
      {'id':'1','name':'Potato','image':'url'},
      {'id':'1','name':'Potato','image':'url'},
      {'id':'1','name':'Potato','image':'url'},
    ];
    return Scaffold(
    body:Column(
      children: [
        Container(
          height:212,
          padding:EdgeInsets.all(35),
          decoration:BoxDecoration(
            borderRadius:BorderRadius.circular(3),
            color:Theme.of(context).colorScheme.primary
          ),
          child:Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  Text('449,Gopal nagar,Bhopal',style:Theme.of(context).textTheme.bodyMedium),
                  InkWell(
                      onTap:(){
                        ApiService.logOut();
                        context.go('/loginPage');
                      },
                      child: CircleAvatar(child:Text('A'),))
                ],
              ),
              Text('Your address',style:Theme.of(context).textTheme.labelSmall?.copyWith(color:Theme.of(context).colorScheme.onSurface)),
              SizedBox(height:15),
              Container(
                width:350,
                height:49,
                margin:EdgeInsets.symmetric(vertical:10),
                decoration:BoxDecoration(
                  borderRadius:BorderRadius.circular(15),
                  color:Colors.orange,
                ),
                child:TextFormField(
                  style:Theme.of(context).textTheme.bodySmall,
                  cursorColor:Colors.black87,
                  decoration:InputDecoration(
                    border:OutlineInputBorder(
                      borderRadius:BorderRadius.circular(15)
                    ),
                    hintText:'Search what you need ?',
                    suffixIcon:Icon(Icons.search_rounded,color:Colors.white,),
                  ),
                ),
              ),
            ],
          ),
        ),
      SizedBox(height:20),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap:(){
                    context.go('/categoryPage');
                  },
                  child: Text('Category',style:TextStyle(color:Colors.black38))),
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection:Axis.horizontal,
          primary:true,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children:category.map((e)=>
              Container(
                child:Column(
                  children: [
                Container(
                  width:60,
                  height:60,
                  margin:EdgeInsets.all(5),
                  decoration:BoxDecoration(
                    borderRadius:BorderRadius.circular(25),
                    color:Colors.teal,
                  ),
                  child:SvgPicture.asset(IconsPath.tomato),
                 ),
                    Text(e['name']!,style:Theme.of(context).textTheme.labelMedium),
                  ],
                ),
              )).toList(),
            ),
          ),
        ),
        SizedBox(height:10),
        Expanded(
          child: GridView.builder(
            itemCount:10,
              gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2),
              itemBuilder:(context, index) {
                return Container(
                  margin:EdgeInsets.all(5),
                  decoration:BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:Theme.of(context).colorScheme.primaryContainer
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          margin:EdgeInsets.all(10),
                          width:300,
                          height:170,
                          decoration:BoxDecoration(
                            borderRadius:BorderRadius.circular(12),
                            color:Colors.teal
                          ),
                          child:Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(IconsPath.potato),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text('    Potato',style:Theme.of(context).textTheme.labelMedium),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.star,color:Colors.yellow,),
                          Icon(Icons.star,color:Colors.yellow,),
                          Icon(Icons.star,color:Colors.yellow,),
                          Icon(Icons.star,color:Colors.yellow,),
                          Icon(Icons.star,color:Colors.grey),
                        ],
                      ),
                      Row(
                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                        children: [
                          Text('    23/KG',style:Theme.of(context).textTheme.labelMedium),
                          Container(
                            margin:EdgeInsets.only(right:12,bottom:5),
                            width:35,
                            height:30,
                            decoration:BoxDecoration(
                              borderRadius:BorderRadius.only(topLeft:Radius.circular(5),bottomRight:Radius.circular(10)),
                              color:Theme.of(context).colorScheme.primary
                            ),
                            child:Icon(Icons.add,color:Colors.white),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
          ),
        )
      ],
    ),
    );
  }
}
