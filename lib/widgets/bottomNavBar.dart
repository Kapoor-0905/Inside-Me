import 'package:flutter/material.dart';
import 'package:inside_me/constants/colors.dart';
import 'package:inside_me/constants/sizes.dart';
import 'package:inside_me/screens/home/home.dart';
import 'package:inside_me/screens/todo/todoScreen.dart';
import 'package:inside_me/widgets/widgets.dart';

class BottomNavBar extends StatelessWidget {
  bool isBlog;
  bool isTodo;
  BottomNavBar({Key? key, required this.isBlog, required this.isTodo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(size.height * 0.01),
      child: Container(
        height: size.height * 0.08,
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: MyColors().tertiaryColor.withOpacity(0.2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                nextScreenReplace(
                    context,
                    Home(
                      isRegisteredNow: false,
                    ));
              },
              child: Container(
                height: size.height * 0.06,
                decoration: isBlog == true
                    ? BoxDecoration(
                        borderRadius: BorderRadius.circular(borderRadius),
                        color: MyColors().primaryColor.withOpacity(0.5),
                      )
                    : null,
                child: Image.asset(
                  'assets/logos/blog.png',
                  height: size.height * 0.05,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                nextScreen(context, TodoScreen());
              },
              child: Container(
                height: size.height * 0.06,
                decoration: isTodo == true
                    ? BoxDecoration(
                        borderRadius: BorderRadius.circular(borderRadius),
                        color: MyColors().tertiaryColor.withOpacity(0.5),
                      )
                    : null,
                child: Image.asset(
                  'assets/logos/todo.png',
                  height: size.height * 0.05,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
