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
String uid;
String bloodgroup;
String age;
String diseases;
String email;
String password;
UserCredential currentUser;
List<ContactsData> contactslist = [];
String contactslistdata = '[]';
Future<void> updateDetails() async {
  try {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.user.uid)
        .set({
      'bloodgroup': bloodgroup,
      'age': age,
      'contacts': contactslistdata,
      'allergies': allergies,
      'diseases': diseases,

      ///TODO: add allergies
      'name': name,
      'imageurl': '',
    });
  } on Exception catch (e) {
    print(e);
  }
  // final userdetail = widget.currentUser.user.uid;
  // final detail = await FirebaseFirestore.instance
  //     .collection('users')
  //     .where('uid', isEqualTo: userdetail)
  //     .get();
  //print(detail.docs.first.data().updateAll((key, value) =>));
}

void extractDetails() async {
  try {
    final _storage = FirebaseFirestore.instance;
    final data = await _storage.collection('users').doc(uid).get();
    var data2 = data.data();
    final mp = data2;
    name = data2['name'];
    bloodgroup = data2['bloodgroup'];
    diseases = data2['diseases'];
    contactslist = data2['contacts'];
    age = data2['age'];
  } on Exception catch (e) {
    print(e);
  }
}

String contactsData;

SharedPreferences pref;

bool darkMode = false;
bool dialEmergencyNumbers = false;
bool recordAudio = false;
bool phraseDetection = false;
String allergies;
