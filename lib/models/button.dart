import 'package:flutter/material.dart';
import 'package:inside_me/constants/colors.dart';
import 'package:inside_me/constants/decorations.dart';
import 'package:inside_me/constants/sizes.dart';

class MyButton extends StatelessWidget {
  String label;
  MyButton({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.85,
      height: size.height * 0.06,
      decoration: BoxDecoration(
        color: MyColors().primaryColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: MyDecoration().primaryTextStyle.copyWith(
                  fontSize: size.width * content,
                  color: Colors.white.withOpacity(0.85),
                ),
          ),
          SizedBox(
            width: size.width * 0.05,
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.white.withOpacity(0.85),
          )
        ],
      ),
    );
  }
}
