import 'dart:async';
import 'recordedFiles.dart';
import 'package:emergency_app/data/data.dart';
import 'package:emergency_app/models/ThemeChanger.dart';
import 'package:emergency_app/models/contacts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import 'login.dart';

class SettingPage extends StatefulWidget {
  static String id = 'SettingPage';
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  double buttonDepth = 30;
  bool switchValue = false;

  void _updateContactsList(int index) {
    setState(() {
      HapticFeedback.lightImpact();
      contactslist.removeAt(index);
    });
    ContactsData.updateContactsListInPref(pref);
  }

  @override
  void initState() {
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
                          FaIcon(
                            FontAwesomeIcons.solidMoon,
                            size: 22,
                          ),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              'Dark Mode',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w500),
                            ),
                          )),
                          Transform.scale(
                            scale: 0.8,
                            child: CupertinoSwitch(
                              onChanged: (value) {
                                setState(() {
                                  darkMode = value;
                                  pref.setBool('dark', darkMode);
                                  ThemeBuilder.of(context).changeTheme(darkMode);
                                });
                              },
                              value: darkMode ?? false,
                              activeColor: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: FaIcon(
                              FontAwesomeIcons.phoneAlt,
                              size: 22,
                            ),
                          ),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Dial Emergency numbers',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  'Emergency Call to 100 when Detected along with messages to your emergency Contacts',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          )),
                          Transform.scale(
                            scale: 0.8,
                            child: CupertinoSwitch(
                              onChanged: (value) async {
                                if (await Permission.phone.status.isDenied) {
                                  await Permission.phone.request();
                                }
                                if (await Permission.phone.status.isGranted) {
                                  setState(() {
                                    dialEmergencyNumbers = value;
                                    pref.setBool(
                                        'emergency', dialEmergencyNumbers);
                                  });
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                      "Permission Denied",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Theme.of(context).buttonColor),
                                    ),
                                    backgroundColor:
                                        Theme.of(context).dividerColor,
                                    elevation: 2,
                                    duration: const Duration(seconds: 3),
                                  ));
                                  setState(() {
                                    value = false;
                                  });
                                }
                              },
                              value: dialEmergencyNumbers ?? false,
                              activeColor: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: FaIcon(
                              FontAwesomeIcons.microphone,
                              size: 22,
                            ),
                          ),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(left: 26),
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Record Audio',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  'Audio will be recorded in Alone Mode for further use if option is enabled',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          )),
                          Transform.scale(
                            scale: 0.8,
                            child: CupertinoSwitch(
                              onChanged: (value) async {
                                if (!phraseDetection) {
                                  if (await Permission
                                          .microphone.status.isDenied
                                      //|| await Permission.speech.isDenied
                                  ) {
                                    await Permission.microphone.request();
                                    //await Permission.speech.request();
                                  }
                                  if (await Permission.microphone.isGranted
                                      //&& await Permission.speech.isGranted
                                  ) {
// =======
//                                           .microphone.status.isDenied ||
//                                       await Permission.speech.isDenied) {
//                                     await Permission.microphone.request();
//                                     await Permission.speech.request();
//                                   }
//                                   if (await Permission.microphone.isGranted &&
//                                       await Permission.speech.isGranted) {
// >>>>>>> Kc
                                    setState(() {
                                      recordAudio = value;
                                      pref.setBool('audio', recordAudio);
                                    });
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                        "Permission Denied",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).buttonColor),
                                      ),
                                      backgroundColor:
                                          Theme.of(context).dividerColor,
                                      elevation: 2,
                                      duration: const Duration(seconds: 3),
                                    ));
                                    setState(() {
                                      recordAudio = false;
                                      value = false;
                                    });
                                  }
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                      "You cannot select Audio recording and Phrase detection simultaneously",
// =======
//                                       "You cannot select Audio recording and phrase detection simultaneously",
// >>>>>>> Kc
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Theme.of(context).buttonColor),
                                    ),
                                    backgroundColor:
                                        Theme.of(context).dividerColor,
                                    elevation: 2,
                                    duration: const Duration(seconds: 4),
                                  ));
                                  setState(() {
                                    value = false;
                                  });
                                }
                              },
                              value: recordAudio ?? false,
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
                          FaIcon(
                            FontAwesomeIcons.solidFileAudio,
                            size: 24,
                          ),
                          Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child:  Text(
                                  'Recorded Audio Files',
                                  style: TextStyle(
                                      fontSize: 22, fontWeight: FontWeight.w500),
                                ),
                              )),
                          IconButton(
                            icon: Icon(Icons.arrow_forward_ios_rounded),
                            iconSize: 24,
                            onPressed: () {
                              Navigator.pushNamed(context, RecordedFiles.id);
                            },
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: FaIcon(
                              FontAwesomeIcons.dotCircle,
                              size: 24,
                            ),
                          ),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Trigger Phrases Detection',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  'If enabled, the app will try to detect Phrases like "Help" to trigger Emergency SMS',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          )),
                          Transform.scale(
                            scale: 0.8,
                            child: CupertinoSwitch(
                              onChanged: (value) async {
                                if (!recordAudio) {
                                  if (await Permission
                                          .microphone.status.isDenied ||
                                      await Permission.speech.isDenied) {
                                    await Permission.microphone.request();
                                    await Permission.speech.request();
                                  }
                                  if (await Permission.microphone.isGranted &&
                                      await Permission.speech.isGranted) {
                                    setState(() {
                                      phraseDetection = value;
                                      //print(phraseDetection);
                                      pref.setBool('phrase', phraseDetection);
                                    });
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                        "You cannot select Audio recording and Phrase detection simultaneously",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).buttonColor),
                                      ),
                                      backgroundColor:
                                          Theme.of(context).dividerColor,
                                      elevation: 2,
                                      duration: const Duration(seconds: 4),
                                    ));
                                    setState(() {
                                      phraseDetection = false;
                                      value = false;
                                    });
                                  }
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                      "You cannot select Audio recording and phrase detection simultaneously",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Theme.of(context).buttonColor),
                                    ),
                                    backgroundColor:
                                        Theme.of(context).dividerColor,
                                    elevation: 2,
                                    duration: const Duration(seconds: 3),
                                  ));
                                  setState(() {
                                    value = false;
                                  });
                                }
                              },
                              value: phraseDetection ?? false,
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
                          FaIcon(
                            FontAwesomeIcons.signOutAlt,
                            size: 24,
                          ),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              'Log Out',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w500),
                            ),
                          )),
                          IconButton(
                            icon: Icon(Icons.arrow_forward_ios_rounded),
                            iconSize: 24,
                            onPressed: () {
                              pref.clear();
                              Navigator.pushNamedAndRemoveUntil(
                                  context, LoginPage.id, (route) => false);
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                )),
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
