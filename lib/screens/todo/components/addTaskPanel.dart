import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inside_me/constants/colors.dart';
import 'package:inside_me/constants/decorations.dart';
import 'package:inside_me/constants/images.dart';
import 'package:inside_me/constants/sizes.dart';
import 'package:inside_me/services/supabase/databaseServices.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddTaskPanel extends StatefulWidget {
  const AddTaskPanel({Key? key}) : super(key: key);

  @override
  State<AddTaskPanel> createState() => _AddTaskPanelState();
}

class _AddTaskPanelState extends State<AddTaskPanel> {
  DbServices dbServices = DbServices();
  bool desc = false;
  double priority = 2;
  DateTime _date = DateTime.now();
  String finalDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  bool isDateSelected = false;
  String taskTitle = '';
  String taskDesc = '';
  TextEditingController _taskController = TextEditingController();
  TextEditingController _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(
        top: size.height * 0.02,
        left: size.width * 0.05,
        right: size.width * 0.05,
      ),
      height: size.height * 0.7,
      decoration: BoxDecoration(
        color: MyColors().primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Add Task',
                style: TextStyle(
                    color: MyColors().tertiaryColor,
                    fontSize: size.width * subHeading,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Kollektif'),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close),
                color: MyColors().secondaryColor,
                iconSize: size.width * 0.05,
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          TextField(
            style: TextStyle(
                color: Colors.white,
                fontSize: size.width * content,
                fontFamily: 'Kollektif'),
            decoration: MyDecoration().addTaskInputDecoration.copyWith(
                  hintText: 'New Task',
                  hintStyle: TextStyle(
                      color: MyColors().tertiaryColor.withOpacity(0.8),
                      fontSize: size.width * subContent,
                      fontFamily: 'Kollektif'
                      // fontWeight: FontWeight.w600,
                      ),
                ),
            onChanged: (value) {
              taskTitle = value;
            },
          ),
          SizedBox(
            height: desc == true ? size.height * 0.02 : size.height * 0.04,
          ),
          Visibility(
            visible: desc == true,
            child: Column(
              children: [
                TextField(
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width * content,
                      fontFamily: 'Kollektif'),
                  minLines: 1,
                  maxLines: 5,
                  decoration: MyDecoration().addTaskInputDecoration.copyWith(
                        hintText: 'Description',
                        hintStyle: TextStyle(
                            color: MyColors().tertiaryColor.withOpacity(0.8),
                            fontSize: size.width * subContent,
                            fontFamily: 'Kollektif'
                            // fontWeight: FontWeight.w600,
                            ),
                      ),
                  onChanged: (value) {
                    taskDesc = value;
                  },
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
              ],
            ),
          ),
          Text(
            'Task Priority',
            style: TextStyle(
                color: MyColors().tertiaryColor,
                fontSize: size.width * subContent,
                fontFamily: 'Kollektif'),
          ),
          Slider(
            value: priority.round().toDouble(),
            min: 1,
            max: 3,
            label: priority == 1
                ? 'Third Priority'
                : priority == 2
                    ? 'Second Priority'
                    : 'First Priority',
            divisions: 2,
            onChanged: (value) {
              setState(() {
                priority = value;
              });
            },
            activeColor: MyColors().tertiaryColor,
            inactiveColor: Color.fromARGB(255, 88, 89, 104),
            thumbColor: MyColors().secondaryColor,
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Visibility(
            visible: isDateSelected == true,
            child: Container(
              alignment: Alignment.center,
              width: size.width * 0.35,
              height: size.height * 0.05,
              decoration: BoxDecoration(
                border: Border.all(
                  color: MyColors().secondaryColor,
                ),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              // selected date here
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '${_date.day}/${_date.month}/${_date.year}',
                    style: TextStyle(
                        color: MyColors().tertiaryColor,
                        fontSize: size.width * subContent,
                        fontFamily: 'Kollektif'),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isDateSelected = false;
                      });
                    },
                    child: Icon(
                      Icons.close,
                      color: MyColors().tertiaryColor,
                      size: size.width * 0.05,
                    ),
                  )
                ],
              ),
            ),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    _showDateTimePicker();
                  },
                  icon: Icon(
                    Icons.watch_later_outlined,
                    color: MyColors().tertiaryColor,
                    size: size.width * 0.08,
                  )),
              IconButton(
                  onPressed: () {
                    setState(() {
                      desc = !desc;
                    });
                  },
                  icon: Icon(
                    Icons.list,
                    color: MyColors().tertiaryColor,
                    size: size.width * 0.08,
                  )),
            ],
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    MyColors().tertiaryColor.withOpacity(0.5)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                )),
              ),
              onPressed: () {
                DbServices()
                    .saveTask(taskTitle.toLowerCase() + '_' + finalDate.trim(),
                        taskTitle, taskDesc, priority, finalDate, false)
                    .then((value) {
                  _taskController.clear();
                  _descController.clear();
                  setState(() {
                    isDateSelected = false;
                  });
                  Fluttertoast.showToast(
                      msg: 'Task Added',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  Navigator.pop(context);
                  void refresh() {
                    setState(() {
                      dbServices.getTasks();
                    });
                  }
                });
                print(_taskController.text.toLowerCase().trim() +
                    '_' +
                    finalDate.trim());
                print(taskTitle);
                print(finalDate);
                print(priority);
                print(taskDesc);
              },
              child: Text(
                'Save',
                style: TextStyle(
                    color: MyColors().primaryColor,
                    fontFamily: 'Kollektif',
                    fontSize: size.width * content),
              ))
        ],
      ),
    );
  }

  // date and tiem picker
  void _showDateTimePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    ).then((date) {
      if (date == null) return;
      setState(() {
        _date = date;
        isDateSelected = true;
        // store date as a string
        finalDate = DateFormat('dd-MM-yyyy').format(date);
      });
    });
  }
}
