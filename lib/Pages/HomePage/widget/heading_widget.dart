import 'dart:ffi';

import 'package:flutter/material.dart';

class HeadingWidget extends StatelessWidget {
  const HeadingWidget({super.key, required this.titleHeading, required this.SubtitleHeading, required this.onTap, required this.buttonText});
  final String titleHeading;
  final String SubtitleHeading;
  final VoidCallback onTap;
  final String buttonText;
  @override
  Widget build(BuildContext context) {
    return Container(
    margin:EdgeInsets.symmetric(horizontal:10,vertical:10),
      child:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment:MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children: [
                Text(titleHeading,style:Theme.of(context).textTheme.labelLarge),
                Text(SubtitleHeading,style:Theme.of(context).textTheme.labelMedium),
              ],
            ),
            Container(
              padding:EdgeInsets.all(10),
              decoration:BoxDecoration(
                borderRadius:BorderRadius.circular(15),
                color:Theme.of(context).colorScheme.primaryContainer,
                border:Border.all(color:Theme.of(context).colorScheme.primary,
                width:1.5
                ),
              ),
              child:Text(buttonText,style:Theme.of(context).textTheme.labelMedium?.copyWith(color:Colors.redAccent)),
            ),
          ],
        ),
      ),
    );
  }
}
