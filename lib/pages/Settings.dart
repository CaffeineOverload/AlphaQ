import 'dart:async';
import 'package:clay_containers/clay_containers.dart';
import 'package:emergency_app/data/constants.dart';
import 'package:emergency_app/models/ThemeChanger.dart';
import 'package:emergency_app/pages/HomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:emergency_app/components/ContactsCard.dart';
import 'package:emergency_app/data/data.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:emergency_app/models/contacts.dart';
import 'package:emergency_app/data/data.dart';
import 'HomePage.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';


class SettingPage extends StatefulWidget {
  static String id = 'SettingPage';
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  double buttonDepth = 30;
  bool switchValue=false;

  void _updateContactsList(int index) {
    setState(() {
      HapticFeedback.lightImpact();
      contactslist.removeAt(index);
    });
    ContactsData.updateContactsListInPref(pref);
  }

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var baseColor = Colors.white;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Theme.of(context).accentColor,
          ),
          onPressed: () {
            HapticFeedback.lightImpact();
            Navigator.pop(context);
            currentIndex = 0;
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(currentDisplaySize.width * 0.0641),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: currentDisplaySize.height * 0.0355),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Settings',
                      overflow: TextOverflow.visible,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: currentDisplaySize.width * 0.1153,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              ///Contacts List Container
              Expanded(
                flex: 14,
                child: Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FaIcon(FontAwesomeIcons.solidMoon, size: 22,),
                            Expanded(child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text('Dark Mode', style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500
                              ),),
                            )),
                            Transform.scale(
                              scale: 0.8,
                              child: CupertinoSwitch(
                                onChanged: (value) {
                                  setState(() {
                                    ThemeBuilder.of(context).changeTheme();
                                    darkMode = value;
                                    pref.setBool('dark', darkMode);
                                  });
                                },
                                value: darkMode??false,
                                activeColor: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FaIcon(FontAwesomeIcons.phoneAlt, size: 22,),
                            Expanded(child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text('Dial Emergency numbers', style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500
                              ),),
                            )),
                            Transform.scale(
                              scale: 0.8,
                              child: CupertinoSwitch(
                                onChanged: (value) {
                                  setState(() {
                                    dialEmergencyNumbers = value;
                                    pref.setBool('emergency', dialEmergencyNumbers);
                                  });
                                },
                                value: dialEmergencyNumbers??false,
                                activeColor: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FaIcon(FontAwesomeIcons.microphone, size: 22,),
                            Expanded(child: Padding(
                              padding: const EdgeInsets.only(left: 26),
                              child: Text('Record Audio', style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500
                              ),),
                            )),
                            Transform.scale(
                              scale: 0.8,
                              child: CupertinoSwitch(
                                onChanged: (value) {
                                  setState(() {
                                    recordAudio = value;
                                    pref.setBool('audio', recordAudio);
                                  });
                                },
                                value: recordAudio??false,
                                activeColor: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FaIcon(FontAwesomeIcons.dotCircle, size: 24,),
                            Expanded(child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text('Trigger Phrases Detection', style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500
                              ),),
                            )),
                            Transform.scale(
                              scale: 0.8,
                              child: CupertinoSwitch(
                                onChanged: (value) {
                                  setState(() {
                                    phraseDetection = value;
                                    pref.setBool('phrase', phraseDetection);
                                  });
                                },
                                value: phraseDetection??false,
                                activeColor: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FaIcon(FontAwesomeIcons.signOutAlt, size: 24,),
                            Expanded(child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text('Log Out', style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500
                              ),),
                            )),
                            IconButton(icon: Icon(Icons.arrow_forward_ios_rounded), iconSize: 24,onPressed: (){
                              pref.clear();
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => HomePage()), (e) => false);
                            },)
                          ],
                        ),
                      ),


                    ],
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void buttonPressed() {
    setState(() {
      buttonDepth = 0;
      Timer(Duration(milliseconds: 100), () {
        setState(() {
          buttonDepth = 30;
        });
      });
    });
  }
}

