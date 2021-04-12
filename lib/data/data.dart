import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergency_app/models/contacts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

int currentIndex = 0;

class DisplaySize {
  double height;
  double width;
  DisplaySize({this.height, this.width});
}

class ProfileData {
  String bloodGroup;
  int age;
  String otherMedicalIssues;

  ProfileData({this.bloodGroup, this.age, this.otherMedicalIssues});
}

DisplaySize currentDisplaySize = DisplaySize();

String name;
String bloodgroup;
String age;
String diseases;
UserCredential currentUser;
String email;
String password;
List<ContactsData> contactslist = [];
Future<void> updateDetails() async {
  SharedPreferences.getInstance().then((prefs) {
    prefs.setString('bloodgroup', bloodgroup);
    prefs.setString('age', age);
    prefs.setString('name', name);
  });
  await FirebaseFirestore.instance
      .collection('users')
      .doc(currentUser.user.uid)
      .set({
    'bloodgroup': bloodgroup,
    'age': age,
    'contacts': [],
    'diseases': [],
    'name': name,
    'imageurl': '',
  });
  // final userdetail = widget.currentUser.user.uid;
  // final detail = await FirebaseFirestore.instance
  //     .collection('users')
  //     .where('uid', isEqualTo: userdetail)
  //     .get();
  //print(detail.docs.first.data().updateAll((key, value) =>));
}

String contactsData;

SharedPreferences pref;

bool darkMode = false;
bool dialEmergencyNumbers = false;
bool recordAudio = false;
bool phraseDetection = false;
