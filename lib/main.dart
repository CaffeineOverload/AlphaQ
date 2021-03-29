import 'package:flutter/material.dart';
import 'pages/HomePage.dart';
import 'pages/Contacts.dart';

void main() {
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
      initialRoute: HomePage.id,
      routes: {
        HomePage.id:(context) => HomePage(),
        ContactsPage.id:(context) => ContactsPage(),
      },
    );
  }
}
