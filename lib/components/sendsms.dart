import 'package:emergency_app/data/data.dart';
import 'package:geolocator/geolocator.dart';
import 'package:telephony/telephony.dart';
import 'package:url_launcher/url_launcher.dart';

void sendSms() async {
  final listener = (SendStatus status) {
    print(status);
  };
  final telephony = Telephony.instance;
  LocationPermission permission = await Geolocator.requestPermission();
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  print(position);
  for (int i = 0; i < contactslist.length; i++) {
    String content =
        'Hi ${contactslist[i].name}, your friend $name is in danger, Please help him/her. His/her location is https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}';
    await telephony.sendSms(
        to: contactslist[i].number, message: content, statusListener: listener);
    if(dialEmergencyNumbers) makeCall();
  }
}

void makeCall() {
  launch("tel://1234");
}
