import 'package:desi_mart/Config/Page_Routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../Config/AssetsPath.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        centerTitle:true,
        title:Text('Fruits',style:Theme.of(context).textTheme.bodyMedium),
        backgroundColor:Theme.of(context).colorScheme.primary,
        leading:IconButton(onPressed:(){
          context.go('/homePage');
        }, icon:Icon(Icons.chevron_left,size:25,)),
      ),
      body:GridView.builder(
        itemCount:8,
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
    );
  }
}
