import 'package:flutter/material.dart';
import 'package:inside_me/constants/colors.dart';
import 'package:inside_me/constants/sizes.dart';

class MyDecoration {
  var primaryTextStyle = TextStyle(
    color: MyColors().primaryColor,
    fontFamily: 'Kollektif',
  );

  var primaryInputDecoration = InputDecoration(
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(
          color: MyColors().tertiaryColor,
        )),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(
          color: MyColors().tertiaryColor,
        )),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(
          color: MyColors().tertiaryColor,
        )),
    filled: true,
    fillColor: MyColors().tertiaryColor.withOpacity(0.6),
  );

  var addTaskInputDecoration = InputDecoration(
    border: UnderlineInputBorder(
        // borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(
          color: MyColors().tertiaryColor,
        )),
    focusedBorder: UnderlineInputBorder(
        // borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(
          color: MyColors().tertiaryColor,
        )),
    enabledBorder: UnderlineInputBorder(
        // borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(
          color: MyColors().tertiaryColor,
        )),
  );
}
