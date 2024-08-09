import 'package:flutter/material.dart';
import 'package:pointage_automatique/screens/home_page.dart';
// import 'package:pointage_automatique/screens/phone_sign_in_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pointage Automatique',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: PhoneSignInPage(),
      home: HomePage(),
    );
  }
}
