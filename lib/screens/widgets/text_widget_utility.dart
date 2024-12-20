import 'package:flutter/material.dart';
import 'package:my_trainings_app/utils/app_constants.dart';

class TextWidgetUtility {
  static Widget buildAppBarTitleText({required String title, Color? color}) {
    return Text(
      title,
      style: StyleUtils.appBarTextStyle(color: color),
    );
  }

  static Widget buildTitleText({required String title, Color? color}) {
    return Text(
      title,
      style: StyleUtils.titleTextStyle(color: color),
    );
  }

  static Widget buildSubTitleText({required String title, Color? color}) {
    return Text(
      title,
      style: StyleUtils.subTitleTextStyle(color: color),
    );
  }

  static Widget buildNormalText(
      {required String title, Color? color, bool? isBold = false}) {
    return Text(
      title,
      style: isBold == false
          ? StyleUtils.normalTextStyle(color: color)
          : StyleUtils.normalBoldTextStyle(color: color),
    );
  }

  static Widget buildSmallText(
      {required String title, Color? color, bool? isBold = false}) {
    return Text(
      title,
      style: isBold == false
          ? StyleUtils.smallTextStyle(color: color)
          : StyleUtils.smallBoldTextStyle(color: color),
    );
  }
}
