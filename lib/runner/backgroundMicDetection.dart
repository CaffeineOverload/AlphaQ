import 'dart:core';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'dart:async';

final stt.SpeechToText _speechToText = stt.SpeechToText();
bool _ready, _listening;
String _lastStatus, _lastError, _lastWords;

bool loop(int timing) {
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
    if (timing == t) {
      timer.cancel();
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
}

void _start() async {
  await _speechToText.listen(onResult: _speechResult);
  _listening = true;
}

void _stop() async {
  _speechToText.stop();
  _listening = false;
}

void _cancel() async {
  _speechToText.cancel();
  _listening = false;
}

void _onStatus(String status) {
  _lastStatus = status;
  print(_lastStatus);
}

void _onError(SpeechRecognitionError errorNotification) {
  _lastError = errorNotification.errorMsg;
  print(_lastError);
}

void _speechResult(SpeechRecognitionResult result) {
  _lastWords = result.recognizedWords;
  print(_lastWords);
}

bool check() {
  if (_lastWords.contains("help")) {
    print("help found");
    return true;
  }
  return false;
}
