import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:inside_me/constants/colors.dart';
import 'package:inside_me/constants/decorations.dart';
import 'package:inside_me/constants/sizes.dart';

class TextInput extends StatefulWidget {
  TextEditingController textController;
  String label;
  String hint;
  bool isObscure;
  TextInputType keyBoardType;
  String variable;
  TextInput(
      {Key? key,
      required this.textController,
      required this.label,
      required this.hint,
      required this.isObscure,
      required this.variable,
      required this.keyBoardType})
      : super(key: key);

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextField(
      controller: widget.textController,
      decoration: MyDecoration().primaryInputDecoration.copyWith(
            hintText: widget.hint,
            hintStyle: MyDecoration().primaryTextStyle.copyWith(
                fontSize: size.width * content,
                color: MyColors().primaryColor.withOpacity(0.7)),
          ),
      obscureText: widget.isObscure,
      keyboardType: widget.keyBoardType,
      onChanged: (value) {
        
      },
    );
  }
}
