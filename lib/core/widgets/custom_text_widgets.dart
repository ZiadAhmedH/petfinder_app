import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;

  const CustomTextWidget({
    super.key,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.maxLines,
  });

  const CustomTextWidget.title28(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
  }) : fontSize = 28,
       fontWeight = FontWeight.bold;
  

  const CustomTextWidget.title24(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
  }) : fontSize = 24,
       fontWeight = FontWeight.bold;


  const CustomTextWidget.subtitle(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
  }) : fontSize = 16,
       fontWeight = FontWeight.w600;

   const CustomTextWidget.subtitleNormal(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
  }) : fontSize = 15,
       fontWeight = FontWeight.w400;

  
  


  const CustomTextWidget.subtitleBold(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
  }) : fontSize = 16,
       fontWeight = FontWeight.bold; 


   const  CustomTextWidget.subtitlew700(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
  }) : fontSize = 16,
       fontWeight = FontWeight.w700;      


  const CustomTextWidget.subtitleSemiBold(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
  }) : fontSize = 16,
       fontWeight = FontWeight.w600;         

  const CustomTextWidget.body(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
  }) : fontSize = 16,
       fontWeight = FontWeight.normal;


  const CustomTextWidget.bodySemiBold(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
  }) : fontSize = 14,
       fontWeight = FontWeight.w600;     

  const CustomTextWidget.small(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
  }) : fontSize = 12,
       fontWeight = FontWeight.normal;
  
  const CustomTextWidget.smallSemiBold(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
  }) : fontSize = 14,
        fontWeight = FontWeight.bold;


  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? Colors.black,
        fontFamily: 'Poppins',
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      
    );
  }
}