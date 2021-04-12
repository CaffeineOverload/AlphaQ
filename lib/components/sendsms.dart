import 'package:emergency_app/data/data.dart';
import 'package:telephony/telephony.dart';

void sendSms() async {
  final listener = (SendStatus status) {
    print(status);
  };
  final telephony = Telephony.instance;
  String temp = '';
  String content = 'Hi $temp your friend $name is in danger please help him';
  for (int i = 0; i < contactslist.length; i++) {
    temp = contactslist[i].name;
    await telephony.sendSms(
        to: contactslist[i].number, message: content, statusListener: listener);
  }
}

void makeCall() {}
