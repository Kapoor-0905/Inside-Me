import 'package:flutter/material.dart';

class FirstPrioity extends StatefulWidget {
  const FirstPrioity({Key? key}) : super(key: key);

  @override
  State<FirstPrioity> createState() => _FirstPrioityState();
}

class _FirstPrioityState extends State<FirstPrioity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(children: [
          Text(
            'First Priority Tasks',
          ),
        ]),
      ),
    );
  }
}
