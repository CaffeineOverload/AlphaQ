import 'package:emergency_app/models/ThemeChanger.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/HomePage.dart';
import 'pages/Contacts.dart';
import 'pages/Settings.dart';
import 'package:emergency_app/data/constants.dart';
import 'package:emergency_app/data/data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
            routes: {
              HomePage.id: (context) => HomePage(),
              ContactsPage.id: (context) => ContactsPage(),
              SettingPage.id: (context) => SettingPage(),
            },
          );

        }
    );
  }
}
