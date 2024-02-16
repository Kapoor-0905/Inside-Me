import 'package:flutter/material.dart';
import 'package:inside_me/constants/colors.dart';
import 'package:inside_me/constants/images.dart';

class TodoTaskTile extends StatefulWidget {
  bool isCompleted = false;
  String taskName;
  String date;
  TodoTaskTile(
      {Key? key,
      required this.isCompleted,
      required this.taskName,
      required this.date})
      : super(key: key);

  @override
  State<TodoTaskTile> createState() => _TodoTaskTileState();
}

class _TodoTaskTileState extends State<TodoTaskTile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(taskTile),
              Row(
                children: [
                  Checkbox(
                      activeColor: MyColors().tertiaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      value: widget.isCompleted,
                      onChanged: (value) {
                        setState(() {
                          widget.isCompleted = value!;
                        });
                      }),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.taskName,
                        style: TextStyle(
                          color: MyColors().primaryColor,
                          fontSize: size.width * 0.05,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Text(
                        "Due Date: " + widget.date,
                        style: TextStyle(
                          color: MyColors().primaryColor,
                          fontSize: size.width * 0.04,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: size.height * 0.01,
          )
        ],
      ),
    );
  }
}
