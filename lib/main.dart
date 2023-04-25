import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:inside_me/screens/splashScreen/splashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await Supabase.initialize(
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1obXFyb29qdHN3d256YXJzcXBnIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODE2NTU5MTMsImV4cCI6MTk5NzIzMTkxM30.K-_-3tNGM40kTGrfVoakPIdLc8oTrxeyeplsgjuoT_o',
      url: 'https://mhmqroojtswwnzarsqpg.supabase.co');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
