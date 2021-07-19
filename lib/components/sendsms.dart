import 'package:emergency_app/data/data.dart';
import 'package:geolocator/geolocator.dart';
import 'package:telephony/telephony.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_sms/flutter_sms.dart';

// void sendSms() async {
//   final listener = (SendStatus status) {
//     print(status);
//   };
//   final telephony = Telephony.instance;
//   LocationPermission permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//   }
//   Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high);
//   print(position);
//   for (int i = 0; i < contactslist.length; i++) {
//     String content =
//         'Hi ${contactslist[i].name}, your friend $name is in danger, Please help him/her. His/her location is https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}';
//     await telephony.sendSms(
//         to: contactslist[i].number, message: content, statusListener: listener);
//     if (dialEmergencyNumbers) makeCall();
//   }
//   listener.
// }
void _sendSMS(String message, List<String> recipents) async {
  String _result = await sendSMS(message: message, recipients: recipents)
      .catchError((onError) {
    print(onError);
  });
  print(_result);
}

Future<void> sendSms() async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  String content =
      'Your friend $name is in danger, Please help him/her. His/her location is https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}';
  List<String> contact = [];
  for (int i = 0; i < contactslist.length; i++) {
    contact.insert(i, contactslist[i].number.toString());
  }
  _sendSMS(content, contact);
}

Future<void> makeCall() async {
  final telephony = Telephony.instance;
  await telephony.dialPhoneNumber('100');
}
