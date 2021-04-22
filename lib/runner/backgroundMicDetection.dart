import 'dart:core';
import 'package:emergency_app/data/data.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'dart:async';

final stt.SpeechToText _speechToText = stt.SpeechToText();
bool _ready, _listening;
String _lastStatus, _lastError, _lastWords;

Future<void> listen() async {
  if (phraseDetection) {
    bool detectonIsOn;
    if (!detectonIsOn) {
      bool init = await _speechToText.initialize(
        onError: (val) => print("onError $val"),
        onStatus: (val) => print("onstatus $val"),
      );
      detectonIsOn = true;
      Timer.periodic(Duration(seconds: 5), (_checktimer) async {
        print(init);
        // if (init) {
        //   _speechToText.listen(
        //     onResult: (val) => setState(() {
        //       var _text = val.recognizedWords;
        //       if (val.hasConfidenceRating && val.confidence > 0) {
        //         var _confidance = val.confidence;
        //       }
        //     }),
        //   );
        //   print("is litensing ${_speechToText.isListening}");
        //   var _confidance;
        //               print("confi $_confidance");
        //   var _text;
        //               print("text $_text");
        //   if (_text == null) {
        // if (_text.contains("help")) {
        //   print("help found");
        // }
        // sendSms();
        // turnOffTimer();
        //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //     content: Text(
        //       "Triggering Emergency protocol",
        //       textAlign: TextAlign.center,
        //       style: TextStyle(color: Theme.of(context).buttonColor),
        //     ),
        //     backgroundColor: Theme.of(context).dividerColor,
        //     elevation: 2,
        //     duration: const Duration(seconds: 3),
        //   ));
        //   _checktimer.cancel();
        // }
        // }
        bool canceltimer;
        if (canceltimer) {
          if (_speechToText != null) {
            _speechToText.cancel();
          }
          _checktimer.cancel();
        }
      });
    }
  }
}
