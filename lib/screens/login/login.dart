import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inside_me/constants/colors.dart';
import 'package:inside_me/constants/decorations.dart';
import 'package:inside_me/constants/images.dart';
import 'package:inside_me/constants/sizes.dart';
import 'package:inside_me/helper/helperFunctions.dart';
import 'package:inside_me/models/button.dart';
import 'package:inside_me/screens/home/home.dart';
import 'package:inside_me/screens/login/components/textInput.dart';
import 'package:inside_me/screens/register/register.dart';
import 'package:inside_me/services/firebase/firebaseAuth.dart';
import 'package:inside_me/services/firebase/firebaseDbServices.dart';
import 'package:inside_me/widgets/widgets.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseAuthService fbAuth = FirebaseAuthService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Image.asset(
                loginBackground,
              ),
              SizedBox(
                height: size.height * 0.07,
              ),
              Text(
                'Welcome Back',
                style: MyDecoration()
                    .primaryTextStyle
                    .copyWith(fontSize: size.width * 0.09),
              ),
              SizedBox(
                height: size.height * 0.018,
              ),
              Text(
                'Login to your account',
                style: MyDecoration().primaryTextStyle.copyWith(
                    fontSize: size.width * 0.04,
                    color: MyColors().primaryColor.withOpacity(0.7)),
              ),
              SizedBox(
                height: size.height * 0.07,
              ),
              Form(
                  child: Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.07, right: size.width * 0.07),
                child: Column(
                  children: [
                    TextField(
                      controller: emailController,
                      decoration: MyDecoration()
                          .primaryInputDecoration
                          .copyWith(
                            hintText: 'Email',
                            hintStyle: MyDecoration().primaryTextStyle.copyWith(
                                fontSize: size.width * content,
                                color:
                                    MyColors().primaryColor.withOpacity(0.7)),
                          ),
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    TextField(
                      controller: passwordController,
                      decoration: MyDecoration()
                          .primaryInputDecoration
                          .copyWith(
                            hintText: 'Password',
                            hintStyle: MyDecoration().primaryTextStyle.copyWith(
                                fontSize: size.width * content,
                                color:
                                    MyColors().primaryColor.withOpacity(0.7)),
                          ),
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                  ],
                ),
              )),
              SizedBox(
                height: size.height * 0.07,
              ),
              GestureDetector(
                onTap: () {
                  login();
                },
                child: MyButton(label: 'Login'),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Text.rich(
                TextSpan(
                  text: 'Don\'t have an account? ',
                  style: MyDecoration().primaryTextStyle.copyWith(
                      fontSize: size.width * subContent,
                      color: MyColors().primaryColor.withOpacity(0.7)),
                  children: [
                    TextSpan(
                      text: 'Sign Up',
                      style: MyDecoration().primaryTextStyle.copyWith(
                          fontSize: size.width * subContent,
                          color: MyColors().secondaryColor,
                          fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          nextScreen(context, Register());
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  login() async {
    setState(() {
      _isLoading = true;
    });
    await fbAuth
        .loginWithUserEmailandPassword(email, password)
        .then((value) async {
      if (value == true) {
        QuerySnapshot snapshot = await FirebaseDbServices(
                uid: FirebaseAuth.instance.currentUser!.uid)
            .getUserData(email);
        // saving value to shared preferences
        await HelperFunctions.savedUserLoggedInStatus(true);
        await HelperFunctions.savedUserNameSF(snapshot.docs[0]['fullName']);
        await HelperFunctions.savedUserEmailSF(email);
        nextScreenReplace(
            context,
            Home(
              isRegisteredNow: false,
            ));
      } else {
        setState(() {
          Fluttertoast.showToast(
              msg: 'Invalid Email or Password',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          _isLoading = false;
        });
      }
    });
  }
}
