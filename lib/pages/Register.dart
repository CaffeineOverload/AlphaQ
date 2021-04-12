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
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        progressIndicator: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.red),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    name = value;
                  },
                  decoration: InputDecoration(
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
                    labelText: 'Age',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  onChanged: (value) {
                    bloodgroup = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'BloodGroup',
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
                      style: TextStyle(color: Colors.white),
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

  Future<void> _createuser() async {
    try {
      final currentuser = await _auth.createUserWithEmailAndPassword(
          email: Email, password: Password);
      await currentuser.user.updateProfile(
        displayName: name,
      );
      SharedPreferences.getInstance().then((prefs) {
        email = Email;
        password = Password;
        prefs.setString('email', Email);
        prefs.setString('password', Password);
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
        'contacts': [],
        'diseases': [],
        'name': name,
        'imageurl': '',
      });
      Navigator.pushNamed(context, HomePage.id);
    } catch (e) {
      // TODO
      print(e);
      showError(context, e);
    }
    setState(() {
      showSpinner = false;
    });
  }
}
