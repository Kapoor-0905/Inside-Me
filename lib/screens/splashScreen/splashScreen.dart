import 'dart:async';

import 'package:flutter/material.dart';
import 'package:inside_me/helper/helperFunctions.dart';
import 'package:inside_me/screens/home/home.dart';
import 'package:inside_me/screens/login/login.dart';
import 'package:inside_me/widgets/widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isSignedIn = false;
  @override
  getUserLoggedInStatus() async {
    await HelperFunctions.getUserLoggedInStatus().then((value) {
      setState(() {
        _isSignedIn = value!;
      });
    });
  }

  void initState() {
    super.initState();
    Timer(Duration(seconds: 6), () {
      _isSignedIn
          ? nextScreenReplace(context, Home(isRegisteredNow: false))
          : nextScreenReplace(context, Login());
    });
    getUserLoggedInStatus();
    print(_isSignedIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Image.asset('assets/logos/splash.gif')),
    );
  }
}
