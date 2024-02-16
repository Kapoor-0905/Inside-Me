import 'package:flutter/material.dart';
import 'package:inside_me/constants/colors.dart';
import 'package:inside_me/screens/profile/profilePage.dart';
import 'package:inside_me/widgets/widgets.dart';

class ProfileIcon extends StatelessWidget {
  String name;
  ProfileIcon({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        nextScreen(
            context,
            ProfilePage(
              name: name,
            ));
        print(name);
      },
      child: CircleAvatar(
        radius: size.width * 0.08,
        backgroundColor: MyColors().primaryColor,
        child: CircleAvatar(
          backgroundColor: MyColors().secondaryColor,
          radius: size.width * 0.075,
          backgroundImage: AssetImage('assets/logos/person.png'),
        ),
      ),
    );
  }
}
