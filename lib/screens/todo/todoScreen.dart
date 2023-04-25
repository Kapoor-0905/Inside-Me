import 'package:flutter/material.dart';
import 'package:inside_me/constants/colors.dart';
import 'package:inside_me/constants/images.dart';
import 'package:inside_me/constants/sizes.dart';
import 'package:inside_me/helper/helperFunctions.dart';
import 'package:inside_me/models/profileIcon.dart';
import 'package:inside_me/screens/todo/components/addTaskPanel.dart';
import 'package:inside_me/screens/todo/components/lessPriorityModel.dart';
import 'package:inside_me/screens/todo/components/priorityModel.dart';
import 'package:inside_me/screens/todo/components/todoTaskTile.dart';
import 'package:inside_me/services/firebase/firebaseDbServices.dart';
import 'package:inside_me/services/supabase/databaseServices.dart';
import 'package:inside_me/widgets/bottomNavBar.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:intl/intl.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  // SlidingUpPanelController _pc = SlidingUpPanelController();
  DbServices dbServices = DbServices();
  String greet = "";
  List firstPTasks = [];
  String name = '';
  String email = '';
  int tasks = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbServices.getTasks();
    getUserDetails();
    getFirstPTasks();
  }

  getUserDetails() async {
    await HelperFunctions.getUserEmailFromSF().then((value) => email = value!);
    print(email);
    await FirebaseDbServices().getUserData(email).then((value) {
      setState(() {
        name = value.docs[0].data()['fullName'];
        email = value.docs[0].data()['email'];
      });
      print(name);
    });
  }

  getFirstPTasks() {
    dbServices.getFirstPriorityTasks().then((value) {
      setState(() {
        firstPTasks = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    var hour = DateTime.now().hour;
    if (hour < 12) {
      greet = "Morning";
    } else if (hour < 17) {
      greet = "Afternoon";
    } else {
      greet = "Evening";
    }

    String month = DateFormat.MMMM().format(now);

    // get day in string
    String day = DateFormat.EEEE().format(now);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors().tertiaryColor,
        onPressed: () {
          showModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(40),
              ),
            ),
            enableDrag: true,
            context: context,
            builder: (context) => AddTaskPanel(),
          );
        },
        child: Icon(
          Icons.add,
          size: size.width * 0.08,
          color: MyColors().primaryColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavBar(
        isBlog: false,
        isTodo: true,
      ),
      backgroundColor: MyColors().primaryColor,
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            color: MyColors().primaryColor,
          ),
          padding: EdgeInsets.only(
            top: size.height * 0.06,
            left: size.width * 0.05,
            right: size.width * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Good $greet",
                        style: TextStyle(
                          color: MyColors().tertiaryColor,
                          fontSize: size.width * heading,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Text(
                        "$day, $month ${now.day}",
                        style: TextStyle(
                          color: MyColors().tertiaryColor,
                          fontSize: size.width * 0.04,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  ProfileIcon(
                    name: name,
                  )
                ],
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      
                    },
                    child: PriorityModel(
                      badge: firstBadge,
                      image: bigRect,
                      label: "First Priority",
                      tasks: firstPTasks.length,
                    ),
                  ),
                  Column(
                    children: [
                      LessPriorityModel(
                          tasks: tasks,
                          label: 'Second Priority',
                          image: smallRect,
                          badge: secondBadge),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      LessPriorityModel(
                          tasks: tasks,
                          label: 'Third Priority',
                          image: smallRect,
                          badge: thirdBadge),
                    ],
                  )
                ],
              ),
              SizedBox(
                  height: size.height * 0.05,
                  child: Divider(
                    color: MyColors().tertiaryColor,
                    thickness: .5,
                  )),
              Text(
                'Today\'s Tasks',
                style: TextStyle(
                  color: MyColors().tertiaryColor,
                  fontSize: size.width * subHeading,
                  fontWeight: FontWeight.w600,
                ),
              ),
              FutureBuilder(
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data[0]['date'] != day
                            ? 1
                            : snapshot.data.length,
                        itemBuilder: (context, index) {
                          return snapshot.data[index]['date'] == day
                              ? TodoTaskTile(
                                  taskName: snapshot.data[index]['task'],
                                  isCompleted: snapshot.data[index]
                                      ['isCompleted'],
                                  date: snapshot.data[index]['date'],
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: 1,
                                  itemBuilder: (context, index) => Container(
                                    alignment: Alignment.center,
                                    child: Row(
                                      children: [
                                        Text(
                                          'Hurray! You have no tasks for today',
                                          style: TextStyle(
                                            fontSize: size.width * 0.06,
                                            fontFamily: 'Kollektif',
                                            color: MyColors().secondaryColor,
                                          ),
                                        ),
                                        Image.asset(
                                          'assets/logos/hurray.gif',
                                          width: size.width * 0.1,
                                        )
                                      ],
                                    ),
                                  ),
                                );
                        },
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
                  future: dbServices.getTasks()),
            ],
          ),
        ),
      ),
    );
  }

  // refresh page
  void refresh() {
    setState(() {
      dbServices.getTasks();
    });
  }
}
