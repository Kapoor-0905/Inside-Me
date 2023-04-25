import 'package:flutter/material.dart';
import 'package:inside_me/constants/colors.dart';
import 'package:inside_me/constants/decorations.dart';
import 'package:inside_me/constants/sizes.dart';
import 'package:inside_me/helper/helperFunctions.dart';
import 'package:inside_me/models/profileIcon.dart';
import 'package:inside_me/screens/blogWrite/blogWritingSpace.dart';
import 'package:inside_me/services/firebase/firebaseDbServices.dart';
import 'package:inside_me/services/supabase/databaseServices.dart';
import 'package:inside_me/widgets/bottomNavBar.dart';
import 'package:inside_me/widgets/widgets.dart';

class Home extends StatefulWidget {
  bool isRegisteredNow;
  Home({Key? key, required this.isRegisteredNow}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String name = '';
  String email = '';
  String uid = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDetails();
    widget.isRegisteredNow
        ? Future.delayed(Duration(seconds: 1), () async {
            await DbServices().addUser(uid, email, name);
            setState(() {
              widget.isRegisteredNow = false;
            });
          })
        : null;
  }

  getUserDetails() async {
    await HelperFunctions.getUserEmailFromSF().then((value) => email = value!);
    print(email);
    await FirebaseDbServices().getUserData(email).then((value) {
      setState(() {
        name = value.docs[0].data()['fullName'];
        email = value.docs[0].data()['email'];
        uid = value.docs[0].data()['uid'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors().tertiaryColor,
        onPressed: () {
          nextScreen(context, BlogWritingSpace());
        },
        child: Icon(
          Icons.add,
          size: size.width * 0.08,
          color: MyColors().primaryColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavBar(
        isBlog: true,
        isTodo: false,
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
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome',
                        textAlign: TextAlign.left,
                        style: MyDecoration().primaryTextStyle.copyWith(
                            fontSize: size.width * subHeading,
                            color: MyColors().tertiaryColor),
                      ),
                      Text(
                        name.split(' ')[0],
                        textAlign: TextAlign.left,
                        style: MyDecoration().primaryTextStyle.copyWith(
                            fontSize: size.width * heading,
                            color: MyColors().tertiaryColor),
                      ),
                    ],
                  ),
                  ProfileIcon(
                    name: name,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
