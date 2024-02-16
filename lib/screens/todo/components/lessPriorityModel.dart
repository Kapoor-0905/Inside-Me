import 'package:flutter/material.dart';
import 'package:inside_me/constants/colors.dart';

class LessPriorityModel extends StatelessWidget {
  int tasks;
  String label;
  String image;
  String badge;
  LessPriorityModel(
      {Key? key, required this.tasks, required this.label, required this.image, required this.badge})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      // height: size.height * 0.3,
      width: size.width * 0.48,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              image,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(size.width * 0.04),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  badge,
                  width: size.width * 0.11,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        color: MyColors().tertiaryColor,
                        fontSize: size.width * 0.04,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Text(
                      "$tasks Tasks",
                      style: TextStyle(
                        color: MyColors().tertiaryColor,
                        fontSize: size.width * 0.05,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
