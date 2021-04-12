import 'package:emergency_app/data/data.dart';
import 'package:telephony/telephony.dart';
import 'package:url_launcher/url_launcher.dart';

void sendSms() async {
  final listener = (SendStatus status) {
    print(status);
  };
  final telephony = Telephony.instance;

  for (int i = 0; i < contactslist.length; i++) {
    String content =
        'Hi ${contactslist[i].name} your friend $name is in danger please help him';
    await telephony.sendSms(
        to: contactslist[i].number, message: content, statusListener: listener);
  }
}

void makeCall() {
  launch("tel://100");
}
