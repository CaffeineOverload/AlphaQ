import 'dart:async';
import 'dart:ui';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:emergency_app/components/PopupMenu.dart';
import 'package:emergency_app/components/ProfileCard.dart';
import 'package:emergency_app/components/UserAvatar.dart';
import 'package:emergency_app/data/data.dart';
import 'package:emergency_app/models/contacts.dart';
import 'package:emergency_app/pages/Contacts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Settings.dart';

class HomePage extends StatefulWidget {
  static String id = 'HomePage';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  TextEditingController nameController = TextEditingController();
//   String name = 'Susan';
  double buttonDepth = 100;
  double button2Depth = 40;
  bool firstvalue = true;
  bool secondvalue = false;
  bool thirdvalue = false;
  bool fourthvalue = false;
  int _pageState = 0;
  double _yOffset = 0;
  bool _editmode = false;
  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
    asyncMethod();
    super.initState();
  }

  Future<void> asyncMethod() async {
    pref = await SharedPreferences.getInstance();
    //name = pref.getString('userName') ?? '';
    darkMode = pref.getBool('dark');
    dialEmergencyNumbers = pref.getBool('emergency');
    recordAudio = pref.getBool('audio');
    phraseDetection = pref.getBool('phrase');
    contactslist =
        ContactsData.decode((pref.getString('contactsData')) ?? '[]');
    currentUser = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    name = currentUser.user.displayName;
  }

  @override
  Widget build(BuildContext context) {
    Color baseColor = Theme.of(context).backgroundColor;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    currentDisplaySize.height = height;
    currentDisplaySize.width = width;
    switch (_pageState) {
      case 0:
        _yOffset = height;
        break;
      case 1:
        _yOffset = 200;
        break;
      case 3:
        _yOffset = 0;
        break;
    }
    return Scaffold(
      backgroundColor: baseColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ///Top bar
                      Row(
                        children: [
                          Hero(
                              tag: 'deep',
                              child: UserAvatar(
                                size: height * 0.054,
                                image: AssetImage('images/image.png'),
                              )),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Hello $name! ',
                                    style: TextStyle(
                                      fontSize: width * 0.0381,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey,
                                      //fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 0,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (_pageState != 1) {
                                          HapticFeedback.selectionClick();
                                          changeBlurSigma(_pageState);
                                          _pageState = 1;
                                          nameController.text = name;
                                          _editmode = false;
                                        }
                                      });
                                    },
                                    child: Text(
                                      'See Profile',
                                      style: TextStyle(
                                          fontSize: width * 0.0331,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.red
                                          //fontWeight: FontWeight.bold),
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: myPopMenu(width, height, context)),
                          /*Container(
                            alignment: Alignment.topLeft,
                            child: myPopMenu(width,height)
                          ),*/
                        ],
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: height * 0.07316),
                        child: Text(
                          'Emergency help needed?',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      Text(
                        'Just press the button',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),

                      ///Emergency Button
                      Padding(
                        padding: EdgeInsets.all(height * 0.0438),
                        child: ClayContainer(
                          color: baseColor,
                          surfaceColor: baseColor,
                          height: height * 0.280,
                          width: height * 0.280,
                          borderRadius: 130,
                          curveType: CurveType.convex,
                          spread: 20,
                          depth: 30,
                          child: Center(
                            child: ClayContainer(
                              color: baseColor,
                              surfaceColor: baseColor,
                              height: height * 0.270,
                              width: height * 0.270,
                              borderRadius: 200,
                              curveType: CurveType.concave,

                              //depth: 100,
                              child: Center(
                                child: ClayContainer(
                                    height: height * 0.230,
                                    width: height * 0.230,
                                    borderRadius: 210,
                                    depth: buttonDepth.toInt(),
                                    curveType: CurveType.convex,
                                    color: baseColor,
                                    surfaceColor: baseColor,
                                    child: GestureDetector(
                                      onLongPress: () {
                                        HapticFeedback.lightImpact();
                                        setState(() {
                                          buttonDepth = 0;
                                        });
                                      },
                                      onLongPressEnd: (LongPressEndDetails
                                          longPressEndDetails) {
                                        setState(() {
                                          buttonDepth = 100;
                                        });
                                      },
                                      onTap: () {
                                        HapticFeedback.lightImpact();
                                        buttonPressed();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'images/button.png'),
                                            ),
                                            shape: BoxShape.circle,
                                            color: Colors.red),
                                      ),
                                    )),
                              ),
                            ),
                          ),
                        ),
                      ),

                      Text(
                        'Feeling Unsafe ?',
                        style: TextStyle(
                            //color: Colors.black,
                            fontSize: height * 0.0282,
                            fontWeight: FontWeight.w700),
                      ),

                      /// Alone Button
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: GestureDetector(
                          onTap: () {
                            HapticFeedback.lightImpact();
                            button2Pressed();
                          },
                          onLongPress: () {
                            HapticFeedback.lightImpact();
                            setState(() {
                              button2Depth = 0;
                            });
                          },
                          onLongPressEnd:
                              (LongPressEndDetails longPressEndDetails) {
                            setState(() {
                              button2Depth = 30;
                            });
                          },
                          child: ClayContainer(
                            //parentColor: baseColor,
                            color: baseColor,
                            surfaceColor: Colors.red,
                            borderRadius: 15,
                            depth: button2Depth.toInt(),
                            //),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                "I'm Alone.",
                                style: TextStyle(
                                    fontSize: 27,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ),

                      /// List of cards
                      /*Container(
                        height: height * 0.134,
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: updateCardDataList.length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return UpdatesCard(
                                  data: updateCardDataList[index]);
                            }),
                      ),*/
                    ],
                  ),

                  ///Floating Nav Bar
                ],
              ),
            ),
          ),

          ///Profile Page
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: controller.value * 4,
                sigmaY: controller.value * 4,
              ),
              child: GestureDetector(
                child: AnimatedContainer(
                    padding: EdgeInsets.all(20),
                    duration: Duration(milliseconds: 1000),
                    curve: Curves.fastLinearToSlowEaseIn,
                    transform: Matrix4.translationValues(0, _yOffset, 1),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Container(
                      decoration: BoxDecoration(
                          //color: Colors.grey,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      changeBlurSigma(_pageState);
                                      _pageState = 0;
                                    });
                                  },
                                  child: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Theme.of(context).buttonColor,
                                    size: height * 0.0355,
                                  )),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _editmode = !_editmode;
                                      //pref.setString('userName', name);
                                    });
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: _editmode
                                        ? Colors.green
                                        : Theme.of(context).buttonColor,
                                    size: _editmode
                                        ? height * 0.0355
                                        : height * 0.0255,
                                  )),
                            ],
                          ),
                          Center(
                            child: UserAvatar(
                              size: height * 0.064,
                              image: AssetImage('images/image.png'),
                            ),
                          ),
                          Container(
                            child: TextField(
                              autofocus: false,
                              textAlign: TextAlign.center,
                              readOnly: _editmode ? false : true,
                              style: TextStyle(
                                  fontSize: height * 0.0226,
                                  fontWeight: FontWeight.w600),
                              keyboardType: TextInputType.name,
                              //textInputAction: TextInputAction.continueAction,
                              controller: nameController,
                              onChanged: (value) {
                                setState(() {
                                  //controller.text = value;
                                  name = value;
                                });
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter Name',
                                hintStyle: TextStyle(
                                    fontSize: height * 0.0186,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Container(
                            //height: 400,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: [
                                    ProfileCard(
                                      height: height,
                                      icon: FaIcon(
                                        FontAwesomeIcons.tint,
                                        color: Colors.red,
                                      ),
                                      title: 'Blood Group',
                                      value: 'B+',
                                    ),
                                    ProfileCard(
                                      height: height,
                                      icon: FaIcon(
                                        FontAwesomeIcons.clipboard,
                                        color: Colors.yellow[600],
                                      ),
                                      title: 'Diseases',
                                      value: 'Na',
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    ProfileCard(
                                      height: height,
                                      icon: FaIcon(
                                        FontAwesomeIcons.userAlt,
                                        color: Colors.blue,
                                      ),
                                      title: 'Age',
                                      value: '19',
                                    ),
                                    ProfileCard(
                                      height: height,
                                      icon: FaIcon(
                                        FontAwesomeIcons.tint,
                                        color: Colors.red,
                                      ),
                                      title: 'Blood Group',
                                      value: 'B+',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )

                    /*GridView.builder(
    itemCount: images.length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 4.0,
    mainAxisSpacing: 4.0
    ),
    itemBuilder: (BuildContext context, int index){
    return Image.network(images[index]);
    },
    ),*/
                    ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        //margin: EdgeInsets.all(5),
        height: height * 0.086,
        decoration: BoxDecoration(
          color: baseColor,
          //borderRadius: BorderRadius.circular(height * 0.0431),
        ),
        child: BottomNavyBar(
            showElevation: false,
            backgroundColor: Colors.transparent,
            items: <BottomNavyBarItem>[
              BottomNavyBarItem(
                  icon: Icon(Icons.home, size: height * 0.03239),
                  title: Center(
                      child: Text(
                    'Home',
                    style: TextStyle(fontSize: height * 0.01619),
                  )),
                  activeColor: Colors.red,
                  inactiveColor: Colors.grey),
              BottomNavyBarItem(
                  icon: Icon(
                    Icons.medical_services_rounded,
                    size: height * 0.03239,
                  ),
                  title: Center(
                      child: Text(
                    'Medical Info',
                    style: TextStyle(fontSize: height * 0.01619),
                  )),
                  activeColor: Colors.red,
                  inactiveColor: Colors.grey),
              BottomNavyBarItem(
                  icon: Icon(Icons.contacts_rounded, size: height * 0.03239),
                  title: Center(
                      child: Text(
                    'Contacts',
                    style: TextStyle(fontSize: height * 0.01619),
                  )),
                  activeColor: Colors.red,
                  inactiveColor: Colors.grey),
              BottomNavyBarItem(
                  icon: Icon(Icons.settings_rounded, size: height * 0.03239),
                  title: Center(
                      child: Text(
                    'Settings',
                    style: TextStyle(fontSize: height * 0.01619),
                  )),
                  activeColor: Colors.red,
                  inactiveColor: Colors.grey),
            ],
            selectedIndex: currentIndex,
            onItemSelected: (index) {
              setState(() {
                currentIndex = index;
                if (currentIndex != 0 && currentIndex != 1) {
                  Navigator.pushNamed(context, getRoutePage(currentIndex));
                }
              });
            }),
      ),
    );
  }

  String getRoutePage(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return HomePage.id;
      case 2:
        return ContactsPage.id;
      case 3:
        return SettingPage.id;
    }
  }

  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        break;
      case 'Settings':
        break;
    }
  }

  void buttonPressed() {
    setState(() {
      buttonDepth = 0;
      Timer(Duration(milliseconds: 100), () {
        setState(() {
          buttonDepth = 100;
        });
      });
    });
  }

  void button2Pressed() {
    setState(() {
      button2Depth = 0;
      Timer(Duration(milliseconds: 100), () {
        setState(() {
          button2Depth = 30;
        });
      });
    });
  }

  changeBlurSigma(int pageState) {
    if (pageState == 0) {
      controller.forward();
    }
    if (pageState == 1) {
      controller.reverse(from: 1);
    }
    controller.addListener(() {
      setState(() {});
    });
  }
}
