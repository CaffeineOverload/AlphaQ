import 'package:emergency_app/data/constants.dart';
import 'package:emergency_app/data/data.dart';
import 'package:emergency_app/models/ThemeChanger.dart';
import 'package:emergency_app/pages/Register.dart';
import 'package:emergency_app/pages/forgetpass.dart';
import 'package:emergency_app/pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/Contacts.dart';
import 'pages/HomePage.dart';
import 'pages/Settings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPreferences.getInstance().then((prefs) {
    darkMode = prefs.getBool('dark') ?? false;
    email = prefs.getString('email');
    password = prefs.getString('password');
  });
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    .then((_) {
      runApp(MyApp());
    });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
        defaultBrightness: darkMode ? Brightness.dark : Brightness.light,
        builder: (context, _brightness) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: (_brightness == Brightness.light) ? light : dark,
            initialRoute: email != null ? HomePage.id : LoginPage.id,

//             initialRoute: LoginPage.id,
            routes: {
              HomePage.id: (context) => HomePage(),
              ContactsPage.id: (context) => ContactsPage(),
              SettingPage.id: (context) => SettingPage(),
              RegisterPage.id: (context) => RegisterPage(),
              ForgetPass.id: (context) => ForgetPass(),
              LoginPage.id: (context) => LoginPage(),
            },
          );
        });
  }
}
