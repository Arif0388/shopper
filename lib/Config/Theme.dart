import 'package:desi_mart/Config/Colors.dart';
import 'package:flutter/material.dart';

var lightTheme = ThemeData(
  useMaterial3:true,
  brightness:Brightness.light,
  scaffoldBackgroundColor:lightBgColor,
  colorScheme:const ColorScheme.light(
    surface:lightBgColor,
    onSurface:lightFontColor,
    primary:lightPrimaryColor,
    primaryContainer:lightPrimaryContainerColor,
    onPrimaryContainer:lightOnPrimaryContainerColor,
    secondary:lightSecondaryColor
  ),


//   Defining Text Theme
textTheme:const TextTheme(

  // Headline
  headlineLarge:TextStyle(
    fontFamily:'Poppins',
    fontSize:32,
    fontWeight:FontWeight.w500,
    color:lightFontColor
  ),
  headlineMedium:TextStyle(
      fontFamily:'Poppins',
      fontSize:20,
      fontWeight:FontWeight.w500,
      color:lightFontColor
  ),
  headlineSmall:TextStyle(
      fontFamily:'Poppins',
      fontSize:18,
      fontWeight:FontWeight.w600,
      color:lightFontColor
  ),

  // Body
  bodyLarge:TextStyle(
      fontFamily:'Poppins',
      fontSize:20,
      fontWeight:FontWeight.w400,
      color:lightFontColor
  ),
  bodyMedium:TextStyle(
      fontFamily:'Poppins',
      fontSize:15,
      fontWeight:FontWeight.w500,
      color:lightFontColor
  ),
  bodySmall:TextStyle(
      fontFamily:'Poppins',
      fontSize:13,
      fontWeight:FontWeight.w400,
      color:lightFontColor
  ),

  // Label
  labelLarge:TextStyle(
      fontFamily:'Poppins',
      fontSize:15,
      fontWeight:FontWeight.w500,
      color:lightOnPrimaryContainerColor
  ),
  labelMedium:TextStyle(
      fontFamily:'Poppins',
      fontSize:12,
      fontWeight:FontWeight.w400,
      color:lightOnPrimaryContainerColor
  ),
  labelSmall:TextStyle(
      fontFamily:'Poppins',
      fontSize:12,
      fontWeight:FontWeight.w500,
      color:lightOnPrimaryContainerColor
  ),
)
);