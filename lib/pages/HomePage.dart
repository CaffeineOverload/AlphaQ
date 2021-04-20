import 'dart:async';
import 'dart:ui';
import 'package:emergency_app/data/constants.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:emergency_app/components/PopupMenu.dart';
import 'package:emergency_app/components/ProfileCard.dart';
import 'package:emergency_app/components/UserAvatar.dart';
import 'package:emergency_app/components/sendsms.dart';
import 'package:emergency_app/data/data.dart';
import 'package:emergency_app/models/contacts.dart';
import 'package:emergency_app/pages/Contacts.dart';
import 'package:emergency_app/pages/alone.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

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
  TextEditingController bloodController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController diseaseController = TextEditingController();
  TextEditingController allergiesController = TextEditingController();
  double buttonDepth = 100;
  double button2Depth = 40;
  bool firstvalue = true;
  bool secondvalue = false;
  bool thirdvalue = false;
  bool fourthvalue = false;
  int _pageState = 0;
  double _yOffset = 0;
  bool _editmode = false;
  bool timerIsOn = false;
  Timer time;
  double percent = 0;
  int timeInSeconds = 0;
  bool dataRecive = true;
  Color baseColor;
  Color baseColor2;
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
    if (await Permission.contacts.status.isDenied) {
      await Permission.contacts.request();
    }
    if (await Permission.locationAlways.status.isDenied) {
      await Permission.locationAlways.request();
    }
    if (await Permission.microphone.status.isDenied) {
      await Permission.microphone.request();
    }
    if (await Permission.sms.status.isDenied) {
      await Permission.sms.request();
    }
    if (await Permission.speech.status.isDenied) {
      await Permission.speech.request();
    }
    if (await Permission.phone.status.isDenied) {
      await Permission.phone.request();
    }
    pref = await SharedPreferences.getInstance();
    bool firebaseAvailable = await extractDetails();
    if (firebaseAvailable) updatePrefs();
    darkMode = pref.getBool('dark') ?? false;
    bloodgroup = pref.getString('bloodgroup') ?? 'A+';
    age = pref.getString('age') ?? 'Na';
    diseases = pref.getString('diseases') ?? 'Na';
    allergies = pref.getString('allergies') ?? 'Na';
    dialEmergencyNumbers = pref.getBool('emergency') ?? false;
    recordAudio = pref.getBool('audio') ?? false;
    phraseDetection = pref.getBool('phrase') ?? false;
    contactslistdata = (pref.getString('contactsData')) ?? '[]';
    contactslist = ContactsData.decode(contactslistdata);
    name = pref.getString('name');
    /*currentUser = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    name = currentUser.user.displayName;*/
    setState(() {
      dataRecive = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    print(contactslistdata);
    print(dataRecive);
    baseColor = Theme.of(context).backgroundColor;
    baseColor2 = Theme.of(context).backgroundColor;
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
      body: ModalProgressHUD(
        opacity: 1,
        color: baseColor,
        inAsyncCall: dataRecive,
        child: Stack(
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
                                  size: height * 0.052,
                                  image: AssetImage('images/Icon.png'),
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
                                      name == null
                                          ? ''
                                          : 'Hello ${name.trim().split(' ').first}',
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
                                            bloodController.text = bloodgroup;
                                            diseaseController.text = diseases;
                                            allergiesController.text =
                                                allergies;
                                            ageController.text = age;
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
                        Hero(
                          tag: "emergency",
                          child: Padding(
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
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          height: height * 0.270,
                                          width: height * 0.270,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            //color: Colors.green
                                          ),
                                          child: CircularPercentIndicator(
                                            radius: height * 0.270,
                                            animation: true,
                                            percent: percent,
                                            animateFromLastPercent: true,
                                            lineWidth: height * 0.040,
                                            circularStrokeCap:
                                                CircularStrokeCap.round,
                                            backgroundColor: Colors.transparent,
                                          ),
                                        ),
                                        Container(
                                            height: height * 0.230,
                                            width: height * 0.230,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: RawMaterialButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (!timerIsOn) {
                                                    timerIsOn = true;
                                                    startTimer(time);

                                                  } else {
                                                    timerIsOn = false;
                                                    percent = 0;
                                                  }
                                                });
                                              },
                                              elevation: 10.0,
                                              fillColor: Colors.red,
                                              highlightColor: Colors.red[900],
                                              highlightElevation: 0,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                                child: !(timeInSeconds == 0)
                                                    ? Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: height *
                                                                        0.0146),
                                                            child: Text(
                                                              timeInSeconds
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      height *
                                                                          0.080,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                          Text(
                                                            'Press to cancel!',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize:
                                                                    height *
                                                                        0.02,
                                                                color: Colors
                                                                    .white),
                                                          )
                                                        ],
                                                      )
                                                    : Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image: AssetImage(
                                                                'images/button.png'),
                                                          ),
                                                        ),
                                                      ),
                                              ),
                                              /*Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        'images/button.png'),
                                                  ),
                                                ),
                                              ),*/
                                              padding: EdgeInsets.all(15.0),
                                              shape: CircleBorder(),
                                            )),
                                      ],
                                    ),
                                  ),
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
                        Hero(
                          tag: 'red button',
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: RawMaterialButton(
                              onPressed: () {
                                Navigator.pushNamed(context, AlonePage.id);
                              },
                              elevation: 8.0,
                              fillColor: Colors.red,
                              highlightColor: Colors.red[900],
                              highlightElevation: 0,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                child: Text(
                                  "I'm Alone.",
                                  style: TextStyle(
                                      fontSize: 27,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              padding: EdgeInsets.all(15.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                        ),
                      ],
                    ),
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
                                IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      setState(() {
                                        _editmode = !_editmode;
                                        if (!_editmode) {
                                          updatePrefs();
                                          updateDetails();

                                          ///TODO: update data on firebase
                                        }
                                        //updateDetails();
                                        //pref.setString('userName', name);
                                      });
                                    },
                                    icon: Icon(
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
                           /* Center(
                              child: UserAvatar(
                                size: height * 0.064,
                                image: AssetImage('images/image.png'),
                              ),
                            ),*/
                            Center(
                              child: Text('User Details:', style: TextStyle(fontWeight: FontWeight.w800, fontSize: height * 0.0326),)
                            ),
                            SizedBox(
                              height: 20,
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
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            //height: 200,
                                            //width: 150,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Blood Group",
                                                      overflow:
                                                          TextOverflow.visible,
                                                      softWrap: true,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize:
                                                              height * 0.0201),
                                                    ),
                                                    FaIcon(
                                                      FontAwesomeIcons.tint,
                                                      color: Colors.red,
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20,
                                                          right: 8,
                                                          left: 4),
                                                  child:
                                                      DropdownButtonHideUnderline(
                                                    child: DropdownButton(
                                                        hint: Text(
                                                            "Blood Group",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300)),
                                                        dropdownColor:
                                                            Theme.of(context)
                                                                .primaryColor,
                                                        icon: Icon(
                                                          Icons
                                                              .keyboard_arrow_down_rounded,
                                                          color: _editmode
                                                              ? Colors.red
                                                              : Colors.grey,
                                                        ),
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                        items: [
                                                          DpItem(context, 'A+',
                                                              height),
                                                          DpItem(context, 'A-',
                                                              height),
                                                          DpItem(context, 'B+',
                                                              height),
                                                          DpItem(context, 'B-',
                                                              height),
                                                          DpItem(context, 'AB+',
                                                              height),
                                                          DpItem(context, 'AB-',
                                                              height),
                                                          DpItem(context, 'O+',
                                                              height),
                                                          DpItem(context, 'O-',
                                                              height),
                                                        ],
                                                        value: bloodgroup,
                                                        onChanged: _editmode
                                                            ? (value) {
                                                                setState(() {
                                                                  bloodgroup =
                                                                      value;
                                                                  print(
                                                                      bloodgroup);
                                                                });
                                                              }
                                                            : null),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: Theme.of(context)
                                                        .dividerColor,
                                                    width: 1)),
                                          ),
                                        ),
                                      ),
                                      /*ProfileCard(
                                        height: height,
                                        icon: FaIcon(
                                          FontAwesomeIcons.tint,
                                          color: Colors.red,
                                        ),
                                        title: 'Blood Group',
                                        controller: bloodController,
                                        onChanged: (value) {
                                          setState(() {
                                            //controller.text = value;
                                            bloodgroup = value;
                                          });
                                        },
                                        editmode: _editmode,
                                      ),*/
                                      ProfileCard(
                                        height: height,
                                        icon: FaIcon(
                                          FontAwesomeIcons.clipboard,
                                          color: Colors.yellow[600],
                                        ),
                                        title: 'Diseases',
                                        controller: diseaseController,
                                        onChanged: (value) {
                                          setState(() {
                                            //controller.text = value;
                                            diseases = value;
                                          });
                                        },
                                        editmode: _editmode,
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
                                        keyboardType: TextInputType.number,
                                        controller: ageController,
                                        onChanged: (value) {
                                          setState(() {
                                            //controller.text = value;
                                            age = value;
                                          });
                                        },
                                        editmode: _editmode,
                                      ),
                                      ProfileCard(
                                        height: height,
                                        icon: FaIcon(
                                          FontAwesomeIcons.bacteria,
                                          color: Colors.green,
                                        ),
                                        title: 'Allergies',
                                        controller: allergiesController,
                                        onChanged: (value) {
                                          setState(() {
                                            //controller.text = value;
                                            allergies = value;
                                          });
                                        },
                                        editmode: _editmode,
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
              /*BottomNavyBarItem(
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
                  inactiveColor: Colors.grey),*/
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
                if (currentIndex != 0 ) {
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
      case 1:
        return ContactsPage.id;
      case 2:
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

  void startTimer(Timer _time) {
    timeInSeconds = 5;
    int time = timeInSeconds * 1000;
    double milisecPercent = time / 100;
    Timer(Duration(milliseconds: 0), () {
      _time = Timer.periodic(Duration(milliseconds: 50), (timer) {
        setState(() {
          if (time > 0) {
            if (!timerIsOn) {
              timer.cancel();
              timeInSeconds = 0;
            } else {
              time -= 50;
              if (time % 1000 == 0) {
                timeInSeconds--;
                print(timeInSeconds);
              }
              if ((time % milisecPercent).toInt() == 0) {
                if (percent < 0.99) {
                  percent += 0.01;
                } else {
                  percent = 1;
                  sendSms();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Triggering Emergency protocol", textAlign: TextAlign.center,style: TextStyle(color:  Theme.of(context).buttonColor),),
                    backgroundColor: Theme.of(context).dividerColor,
                    elevation: 2,
                    duration: const Duration(seconds: 3),
                  ));
                  ///TODO: send sms
                }
              }
            }
          } else {
            percent = 0;
            timer.cancel();
            timerIsOn = false;
          }
        });
      });
    });
  }

  void updatePrefs() {
    pref.setString('bloodgroup', bloodgroup ?? '');
    pref.setString('age', age ?? '');
    pref.setString('name', name ?? '');
    pref.setString('diseases', diseases ?? '');
    pref.setString('allergies', allergies ?? '');
    pref.setString('contactsData', contactslistdata ?? '');
    print('pref updated!');
  }

  DropdownMenuItem<String> DpItem(
      BuildContext context, String text, double height) {
    return DropdownMenuItem(
      child: Container(
        child: Text(
          text,
          style: TextStyle(
              color: Theme.of(context).buttonColor,
              fontWeight: FontWeight.w700,
              fontSize: height * 0.0301,
              fontFamily: 'Quicksand'),
        ),
      ),
      value: text,
    );
  }

}
