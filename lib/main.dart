import 'package:flutter/material.dart';
import 'package:sanad_software_project/theme.dart';
import 'package:sanad_software_project/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: Colors.white
        
      ),
      home: welcome(),
    );
  }
}
