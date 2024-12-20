import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppConstants {
  static final List<String> IMG_DATA = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  ];
}

class AppColors {
  static const primaryColor = Color.fromRGBO(255, 72, 85, 1);

  static const verticalDividerColor = Color.fromRGBO(193, 193, 193, 1);
  static const greyColor = Colors.grey;
  static const lightGreyColor = Color.fromRGBO(242, 242, 242, 1);

  static const whiteColor = Colors.white;
  static const blackColor = Colors.black;
}

class StyleUtils {
  StyleUtils._();

  static appBarTextStyle({Color? color}) => GoogleFonts.aBeeZee(
        color: color ?? AppColors.whiteColor,
        fontWeight: FontWeight.bold,
        fontSize: 26,
      );
  static titleTextStyle({Color? color}) => GoogleFonts.aBeeZee(
        color: color ?? AppColors.blackColor,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      );
  static subTitleTextStyle({Color? color}) => GoogleFonts.aBeeZee(
        color: color ?? AppColors.blackColor,
        fontWeight: FontWeight.bold,
        fontSize: 15,
      );
  static normalTextStyle({Color? color}) => GoogleFonts.aBeeZee(
        color: color ?? AppColors.blackColor,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );
  static normalBoldTextStyle({Color? color}) => GoogleFonts.aBeeZee(
        color: color ?? AppColors.blackColor,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      );
  static smallTextStyle({Color? color}) => GoogleFonts.aBeeZee(
        color: color ?? AppColors.blackColor,
        fontWeight: FontWeight.normal,
        fontSize: 10,
      );
  static smallBoldTextStyle({Color? color}) => GoogleFonts.aBeeZee(
        color: color ?? AppColors.blackColor,
        fontWeight: FontWeight.w600,
        fontSize: 10,
      );
}
