import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  Client client = Client();
  client
      .setEndpoint('http://localhost/v1')
      .setProject('inside_me')
      .setSelfSigned(
          status:
              true); // For self signed certificates, only use for development
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(
        color: Colors.red,
        child: Column(
          children: [
            Center(
              child: Text(
                'Hello World',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  // launch url
                  launchUrl(Uri.parse(
                      'http://localhost/v1/account/sessions/oauth2/callback/google/inside_me'));
                },
                child: Text('Click Me')),
          ],
        ),
      ),
    );
  }
}
