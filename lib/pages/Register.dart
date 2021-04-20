import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergency_app/data/commons.dart';
import 'package:emergency_app/data/data.dart';
import 'package:emergency_app/pages/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  static final id = 'Register';
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String Email;
  String Password;
  String tempBlood;
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        progressIndicator: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.red),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: ListView(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    name = capitalise(value);
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    hintStyle: TextStyle(color: Colors.grey[700]),
                    hintText: 'Enter Your Full Name',
                    labelStyle: TextStyle(color: Colors.red),
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    Email = value;
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    hintStyle: TextStyle(color: Colors.grey[700]),
                    hintText: 'Enter Your Email',
                    labelStyle: TextStyle(color: Colors.red),
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  obscureText: true,
                  onChanged: (value) {
                    Password = value;
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    hintStyle: TextStyle(color: Colors.grey[700]),
                    hintText: 'Enter Your Password',
                    labelStyle: TextStyle(color: Colors.red),
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    age = value;
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    hintStyle: TextStyle(color: Colors.grey[700]),
                    hintText: 'Enter Your Age',
                    labelStyle: TextStyle(color: Colors.red),
                    labelText: 'Age',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  /*BoxDecoration(
                        //color: Colors.white,
                        border: Border.all(
                            color: Colors.grey, style: BorderStyle.solid, width: 1),
                        borderRadius: BorderRadius.circular(20)),*/
                  child: InputDecorator(
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      labelText: 'Blood Group',
                      labelStyle: TextStyle(color: Colors.red),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          hint: Text("Select your Blood Group",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300)),
                          dropdownColor: Theme.of(context).backgroundColor,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Colors.red,
                          ),
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            //fontWeight: FontWeight.bold),
                          ),
                          items: [
                            DpItem(context, 'A+'),
                            DpItem(context, 'A-'),
                            DpItem(context, 'B+'),
                            DpItem(context, 'B-'),
                            DpItem(context, 'AB+'),
                            DpItem(context, 'AB-'),
                            DpItem(context, 'O+'),
                            DpItem(context, 'O-'),
                          ],
                          value: tempBlood,
                          onChanged: (value) {
                            setState(() {
                              tempBlood = value;
                              print(tempBlood);
                            });
                          }),
                    ),
                  ),
                ),
                /*TextField(
                  onChanged: (value) {
                    bloodgroup = value;
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.red, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    hintStyle:TextStyle(color: Colors.grey[700]) ,
                    hintText: 'Enter Your Blood Group',
                    labelStyle: TextStyle(color: Colors.red),
                    labelText: 'BloodGroup',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                ),*/
                SizedBox(height: 20),
                TextField(
                  onChanged: (value) {
                    diseases = value;
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    hintStyle: TextStyle(color: Colors.grey[700]),
                    hintText: 'Mention if you have any chronic disease',
                    labelStyle: TextStyle(color: Colors.red),
                    labelText: 'Diseases',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  onChanged: (value) {
                    allergies = value;
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    hintStyle: TextStyle(color: Colors.grey[700]),
                    hintText: 'Mention if you any allergies',
                    labelStyle: TextStyle(color: Colors.red),
                    labelText: 'Allergies',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: FlatButton(
                    onPressed: () {
                      setState(() {
                        showSpinner = true;
                      });
                      _createuser();
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(
                          color: Theme.of(context).backgroundColor,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> DpItem(BuildContext context, String text) {
    return DropdownMenuItem(
      child: Container(
        child: Text(
          text,
          style: TextStyle(
              color: Theme.of(context).buttonColor,
              fontSize: 16,
              fontWeight: FontWeight.w300),
        ),
      ),
      value: text,
    );
  }

  Future<void> _createuser() async {
    try {
      final currentuser = await _auth.createUserWithEmailAndPassword(
          email: Email, password: Password);
      await currentuser.user.updateProfile(
        displayName: name,
      );
      bloodgroup = tempBlood;
      SharedPreferences.getInstance().then((prefs) {
        uid = currentuser.user.uid;
        prefs.setString('uid', uid);
        prefs.setString('bloodgroup', bloodgroup);
        prefs.setString('age', age);
        prefs.setString('name', name);
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentuser.user.uid)
          .set({
        'bloodgroup': bloodgroup,
        'age': age,
        'contacts': '[]',
        'diseases': diseases,

        ///TODO: add allergies
        'allergies': allergies,
        'name': name,
        'imageurl': '',
      });
      Navigator.pushNamedAndRemoveUntil(context, HomePage.id, (e) => false);
    } catch (e) {
      print(e);
      showError(context, e);
    }
    setState(() {
      showSpinner = false;
    });
  }

  String capitalise(String a) {
    List<String> list = a.split(" ");
    a = "";
    for (int i = 0; i < list.length; i++) {
      a = a + ' ';
      a = a + list[i][0].toUpperCase() + list[i].substring(1);
    }
    return a;
  }
}
