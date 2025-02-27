import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controller/banner_controller.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    CarouselController carouselController = CarouselController();
    BannerController bannerController = Get.put(BannerController());
    return Container(
      child:Obx(() =>
          CarouselSlider(
            items:bannerController.banners.map((e)=> ClipRRect(
              borderRadius:BorderRadius.circular(10),
              child:CachedNetworkImage(imageUrl:e,fit:BoxFit.cover,width:380,
                placeholder: (context, url) => ColoredBox(color:Colors.white,child:Center(child: CupertinoActivityIndicator()),
                ),
                errorWidget:(context, url, error) =>Icon(Icons.error),
              ),
            )).toList(),
            options:CarouselOptions(
              scrollDirection:Axis.horizontal,
              autoPlay:true,
              aspectRatio:1.8,
              viewportFraction:10,
              animateToClosest:true
            ),
          )
      ),
    );
  }
}
