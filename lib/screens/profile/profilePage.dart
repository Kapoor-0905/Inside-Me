import 'package:flutter/material.dart';
import 'package:inside_me/constants/colors.dart';
import 'package:inside_me/constants/decorations.dart';
import 'package:inside_me/constants/sizes.dart';
import 'package:inside_me/helper/helperFunctions.dart';
import 'package:inside_me/screens/login/login.dart';
import 'package:inside_me/services/firebase/firebaseAuth.dart';
import 'package:inside_me/widgets/widgets.dart';

class ProfilePage extends StatefulWidget {
  String name;
  ProfilePage({Key? key, required this.name}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: size.height * 0.03),
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          color: MyColors().primaryColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {
                      goBack(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: MyColors().tertiaryColor,
                    )),
                Text(
                  'Profile',
                  style: MyDecoration().primaryTextStyle.copyWith(
                      fontSize: size.width * 0.06,
                      color: MyColors().tertiaryColor),
                ),
                IconButton(
                  onPressed: () {},
                  icon:
                      Icon(Icons.info_outline, color: MyColors().tertiaryColor),
                )
              ],
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            CircleAvatar(
              radius: size.width * 0.25,
              backgroundColor: MyColors().primaryColor,
              child: CircleAvatar(
                backgroundColor: MyColors().secondaryColor,
                radius: size.width * 0.2,
                backgroundImage: AssetImage('assets/logos/person.png'),
              ),
            ),
            Text(
              widget.name,
              style: MyDecoration().primaryTextStyle.copyWith(
                  fontSize: size.width * 0.08, color: MyColors().tertiaryColor),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      '0',
                      style: MyDecoration().primaryTextStyle.copyWith(
                          fontSize: size.width * 0.08,
                          color: MyColors().tertiaryColor),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Text(
                      'Blogs',
                      style: MyDecoration().primaryTextStyle.copyWith(
                          fontSize: size.width * 0.04,
                          color: MyColors().tertiaryColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.03,
                  child: VerticalDivider(
                    color: MyColors().tertiaryColor,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      '0',
                      style: MyDecoration().primaryTextStyle.copyWith(
                          fontSize: size.width * 0.08,
                          color: MyColors().tertiaryColor),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Text(
                      'Todos',
                      style: MyDecoration().primaryTextStyle.copyWith(
                          fontSize: size.width * 0.04,
                          color: MyColors().tertiaryColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.03,
                  child: VerticalDivider(
                    color: MyColors().tertiaryColor,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      '0',
                      style: MyDecoration().primaryTextStyle.copyWith(
                          fontSize: size.width * 0.08,
                          color: MyColors().tertiaryColor),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Text(
                      'Notes',
                      style: MyDecoration().primaryTextStyle.copyWith(
                          fontSize: size.width * 0.04,
                          color: MyColors().tertiaryColor),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () async {
            await FirebaseAuthService().signOut();
            nextScreenReplace(context, Login());
          },
          child: Text(
            'Logout',
            style: MyDecoration().primaryTextStyle.copyWith(
                fontSize: size.width * 0.06, color: MyColors().tertiaryColor),
          ),
          style: ElevatedButton.styleFrom(
            primary: MyColors().secondaryColor,
            minimumSize: Size(size.width, size.height * 0.08),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        ),
      ),
      backgroundColor: MyColors().primaryColor,
    );
  }
}
