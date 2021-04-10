
import 'package:emergency_app/models/ThemeChanger.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:emergency_app/pages/Register.dart';
import 'package:emergency_app/pages/forgetpass.dart';
import 'package:emergency_app/pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/HomePage.dart';
import 'pages/Contacts.dart';
import 'pages/Settings.dart';
import 'package:emergency_app/data/constants.dart';
import 'package:emergency_app/data/data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences.getInstance().then((prefs) {
    darkMode = prefs.getBool('dark') ?? false;
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return ThemeBuilder(
        defaultBrightness: darkMode?Brightness.dark:Brightness.light,
        builder: (context, _brightness) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: (_brightness == Brightness.light)?light:dark,
            initialRoute: HomePage.id,
//             initialRoute: LoginPage.id,
            routes: {
              HomePage.id: (context) => HomePage(),
              ContactsPage.id: (context) => ContactsPage(),
              SettingPage.id: (context) => SettingPage(),
        RegisterPage.id: (context) => RegisterPage(),
        ForgetPass.id: (context) => ForgetPass(),
            },
          );

        }
    );
  }
}
