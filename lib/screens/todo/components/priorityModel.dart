import 'package:flutter/material.dart';
import 'package:inside_me/constants/colors.dart';

class PriorityModel extends StatelessWidget {
  int tasks;
  String label;
  String image;
  String badge;
  PriorityModel(
      {Key? key,
      required this.tasks,
      required this.label,
      required this.image,
      required this.badge})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      // height: size.height * 0.3,
      width: size.width * 0.4,
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
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  badge,
                  width: size.width * 0.11,
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                Text(
                  label,
                  style: TextStyle(
                    color: MyColors().tertiaryColor,
                    fontSize: size.width * 0.045,
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
                    fontSize: size.width * 0.055,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
