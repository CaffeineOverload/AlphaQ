import 'dart:async';

import 'package:clay_containers/clay_containers.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:emergency_app/components/PopupMenu.dart';
import 'package:emergency_app/components/sendsms.dart';
import 'package:emergency_app/data/data.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
// import 'package:emergency_app/runner/backgroundMicDetection.dart';1
import 'package:record/record.dart';
import 'dart:core';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';

final stt.SpeechToText _speechToText = stt.SpeechToText();
bool _ready, _listening;
String _lastStatus, _lastError, _lastWords;

class AlonePage extends StatefulWidget {
  static String id = 'AlonePage';
  @override
  _AlonePageState createState() => _AlonePageState();
}

Future<void> initState() async {
  bool result = await Record.hasPermission();
  print("initcalled");
  final dir = await getExternalStorageDirectory();
  String path = dir.path +
      '/' +
      DateTime.now().millisecondsSinceEpoch.toString() +
      '.m4a';
  //TODO path=/storage/emulated/0/Android/data/com.caffineoverflow.emergency_app/files/1618846367115.m4a
  print(path);
  if (result == true) {
    print("recoeding starded");
    await Record.start(
      path: path, // required
      encoder: AudioEncoder.AAC, // by default
      bitRate: 128000, // by default
      samplingRate: 44100, // by default
    );
  }
}

class _AlonePageState extends State<AlonePage> {
  int timeInMinutes = 0;
  int seconds = 0;
  double percent = 0;
  bool timerIsOn = false;
  Timer time;
  bool recordIsOn = false;
  @override
  void initState() {
    asyncMethod();
    super.initState();
  }

  Future<void> asyncMethod() async {
    if (recordIsOn == false) {
      bool result = await Record.hasPermission();
      print("initcalled");
      final dir = await getExternalStorageDirectory();
      String path = dir.path +
          '/' +
          DateTime.now().millisecondsSinceEpoch.toString() +
          '.m4a';
      //TODO path=/storage/emulated/0/Android/data/com.caffineoverflow.emergency_app/files/1618846367115.m4a
      print(path);
      if (result == true) {
        print("recoeding starded");
        await Record.start(
          path: path, // required
          encoder: AudioEncoder.AAC, // by default
          bitRate: 128000, // by default
          samplingRate: 44100, // by default
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = currentDisplaySize.height;
    double width = currentDisplaySize.width;
    Color baseColor = Theme.of(context).backgroundColor;
    return Scaffold(
      backgroundColor: baseColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        stopRecording();
                        _stop();
                        _cancel();
                        timerIsOn = false;
                        percent = 0;
                        Navigator.pop(context);
                      },
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
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: height * 0.07316),
                    child: Text(
                      'Alone Mode',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: height * 0.02316),
                    child: Text(
                      "After the timer starts, if you don't respond (Press the button below) in 15 min, The app will inform your peers that you in danger.",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    child: Hero(
                      tag: "emergency",
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.0638, bottom: height * 0.0438),
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
                                                // print(loop());
                                                initState();
                                                loop();
                                                startTimer(time);
                                              } else {
                                                turnOffTimer();
                                                Timer(
                                                    Duration(milliseconds: 600),
                                                    () {
                                                  timerIsOn = true;
                                                  startTimer(time);
                                                });
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
                                            child: !(seconds == 0)
                                                ? Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: height *
                                                                    0.0276),
                                                        child: Text(
                                                          "${seconds ~/ 60}:${seconds % 60}"
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: height *
                                                                  0.060,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                      Text(
                                                        "I'm Here.",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize:
                                                                height * 0.03,
                                                            color:
                                                                Colors.white),
                                                      )
                                                    ],
                                                  )
                                                : Container(
                                                    child: Text(
                                                      "Press to start",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize:
                                                              height * 0.040,
                                                          color: Colors.white),
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
                  ),
                  Hero(
                    tag: 'red button',
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: RawMaterialButton(
                        onPressed: () {
                          turnOffTimer();
                          _stop();
                          _cancel();
                          stopRecording();
                        },
                        elevation: 8.0,
                        fillColor: Colors.red,
                        highlightColor: Colors.red[900],
                        highlightElevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Text(
                            "Stop",
                            style: TextStyle(
                                fontSize: 27,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        padding: EdgeInsets.all(10.0),
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
    );
  }

  Future<bool> checkRecording() async {
    return await Record.isRecording();
  }

  void stopRecording() async {
    await Record.stop();
  }

  bool loop() {
    int t = 0;
    init();
    _start();
    const time = const Duration(minutes: 1);
    new Timer.periodic(time, (timer) {
      _stop();
      if (check()) {
        return true;
      }
      t++;
      if (t == 15) {
        timer.cancel();
        return false;
      }
      _start();
    });
    return false;
  }

  void init() async {
    _ready = await _speechToText.initialize(
      onError: _onError,
      onStatus: _onStatus,
    );
    print("detection init");
  }

  void _start() async {
    print("Detection Started");
    await _speechToText.listen(onResult: _speechResult);
    _listening = true;
    // setState(() {
    //   _listening = true;
    // });
  }

  void _stop() async {
    _speechToText.stop();
    _listening = false;

    // setState(() {
    //   _listening = false;
    // });
    print("detection stopped");
  }

  void _cancel() async {
    _speechToText.cancel();
    _listening = false;

    // setState(() {
    //   _listening = false;
    // });
  }

  void _onStatus(String status) {
    _lastStatus = status;
    // setState(() {
    //   _lastStatus = status;
    // });
    print(_lastStatus);
  }

  void _onError(SpeechRecognitionError errorNotification) {
    setState(() {
      _lastError = errorNotification.errorMsg;
    });
    print(_lastError);
  }

  void _speechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
    print(_lastWords);
  }

  bool check() {
    print(_lastWords);
    if (_lastWords.contains("help")) {
      print("help found");
      return true;
    }
    return false;
  }

  void startTimer(Timer _time) {
    timeInMinutes = 15;
    int tempSec = timeInMinutes * 60;
    seconds = timeInMinutes * 60;
    _time = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (!timerIsOn) {
          timer.cancel();
          seconds = 0;
        } else if (seconds > 0) {
          seconds--;
          percent = (tempSec - seconds) / tempSec;
          if (percent < 0.99) {
            percent += 0.01;
          } else {
            percent = 1;

            ///TODO: send sms
            sendSms();
            print("Done Biatch! 1");
          }
        } else {
          percent = 0;
          print("Done Biatch! 2");
          timer.cancel();
          timerIsOn = false;
        }
      });
    });

    /*double secPercent = (seconds / 100);
      _time = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (seconds > 0) {
            if (!timerIsOn) {
              timer.cancel();
              timeInMinutes = 0;
            } else {
              seconds -= 1;
              //print((double.parse((seconds % secPercent).toStringAsFixed(2))));
              if (seconds % 60 == 0) {
                timeInMinutes--;
                print(timeInMinutes);
              }
              if ( seconds % secPercent == 0) {
                if (percent < 0.99) {
                  percent += 0.01;
                } else {
                  percent = 1;
                  print("Done Biatch!");
                }
              }
            }
          } else {
            percent = 0;
            print("Done Biatch!");
            timer.cancel();
            timerIsOn = false;
          }
        });
      });*/
  }

  void turnOffTimer() {
    timerIsOn = false;
    percent = 0;
  }
}
