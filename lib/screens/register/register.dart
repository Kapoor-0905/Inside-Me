import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:inside_me/constants/colors.dart';
import 'package:inside_me/constants/decorations.dart';
import 'package:inside_me/constants/images.dart';
import 'package:inside_me/constants/sizes.dart';
import 'package:inside_me/models/button.dart';
import 'package:inside_me/screens/home/home.dart';
import 'package:inside_me/screens/login/components/textInput.dart';
import 'package:inside_me/screens/login/login.dart';
import 'package:inside_me/services/firebase/firebaseAuth.dart';
import 'package:inside_me/services/supabase/authServices.dart';
import 'package:inside_me/services/supabase/databaseServices.dart';
import 'package:inside_me/widgets/widgets.dart';
import 'package:inside_me/helper/helperFunctions.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  FirebaseAuthService fbAuth = FirebaseAuthService();
  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String name = '';
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
                'Welcome',
                style: MyDecoration()
                    .primaryTextStyle
                    .copyWith(fontSize: size.width * 0.09),
              ),
              SizedBox(
                height: size.height * 0.018,
              ),
              Text(
                'Register a new account',
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
                      controller: nameController,
                      decoration: MyDecoration()
                          .primaryInputDecoration
                          .copyWith(
                            hintText: 'Full Name',
                            hintStyle: MyDecoration().primaryTextStyle.copyWith(
                                fontSize: size.width * content,
                                color:
                                    MyColors().primaryColor.withOpacity(0.7)),
                          ),
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        name = value;
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
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
                    fbRegister();
                  },
                  child: MyButton(label: 'Register')),
              SizedBox(
                height: size.height * 0.05,
              ),
              Text.rich(
                TextSpan(
                  text: 'Already have an account? ',
                  style: MyDecoration().primaryTextStyle.copyWith(
                      fontSize: size.width * subContent,
                      color: MyColors().primaryColor.withOpacity(0.7)),
                  children: [
                    TextSpan(
                      text: 'Log In',
                      style: MyDecoration().primaryTextStyle.copyWith(
                          fontSize: size.width * subContent,
                          color: MyColors().secondaryColor,
                          fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          nextScreen(context, Login());
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

  fbRegister() async {
    setState(() {
      _isLoading = true;
    });
    if (name == '' || email == '' || password == '') {
      Fluttertoast.showToast(
          msg: 'Please fill all the fields',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      setState(() {
        _isLoading = false;
      });
    } else {
      await fbAuth
          .registerUserWithEmailandPassword(name, email, password)
          .then((value) async {
        if (value == true) {
          await HelperFunctions.savedUserLoggedInStatus(true);
          await HelperFunctions.savedUserNameSF(name);
          await HelperFunctions.savedUserEmailSF(email);

          nextScreenReplace(
              context,
              Home(
                isRegisteredNow: true,
              ));
        } else {
          setState(() {
            Fluttertoast.showToast(
                msg: 'Registration Failed',
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

  // register() async {
  //   if (nameController.text.isEmpty) {
  //     Fluttertoast.showToast(msg: 'Name is required');
  //   } else if (emailController.text.isEmpty) {
  //     Fluttertoast.showToast(msg: 'Email is required');
  //   } else if (passwordController.text.isEmpty) {
  //     Fluttertoast.showToast(msg: 'Password is required');
  //   } else {
  //     await AuthServices().signUpWithEmail(name, email, password).then((value) {
  //       if (value == 'success') {
  //         HelperFunctions.savedUserLoggedInStatus(true);
  //         HelperFunctions.savedUserNameSF(name);
  //         HelperFunctions.savedUserEmailSF(email);
  //         Fluttertoast.showToast(
  //             msg: 'Registration Successful',
  //             toastLength: Toast.LENGTH_LONG,
  //             gravity: ToastGravity.BOTTOM,
  //             timeInSecForIosWeb: 1,
  //             backgroundColor: Colors.green,
  //             textColor: Colors.white,
  //             fontSize: 16.0);
  //         nextScreenReplace(context, Home());
  //       } else {
  //         Fluttertoast.showToast(msg: value);
  //       }
  //     });
  //   }
  // }
}
