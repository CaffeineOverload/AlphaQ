import 'package:record/record.dart';

void startRecording() async {
// Check and request permission
  bool result = await Record.hasPermission();
  if (result == true) {
    await Record.start(
      path: 'aFullPath/myFile.m4a', // required
      encoder: AudioEncoder.AAC, // by default
      bitRate: 128000, // by default
      samplingRate: 44100, // by default
    );
  }
}

void stopRecording() async {
  await Record.stop();
}

Future<bool> checkRecording() async {
  return await Record.isRecording();
}
