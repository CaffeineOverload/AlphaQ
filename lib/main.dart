import 'package:emergency_app/pages/Register.dart';
import 'package:emergency_app/pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'pages/Contacts.dart';
import 'pages/HomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xff065DE9),
        primaryColorLight: Color(0xff81AEF4),
        fontFamily: 'Quicksand',
      ),
      initialRoute: LoginPage.id,
      routes: {
        HomePage.id: (context) => HomePage(),
        ContactsPage.id: (context) => ContactsPage(),
        LoginPage.id: (context) => LoginPage(),
        RegisterPage.id: (context) => RegisterPage(),
      },
    );
  }
}
