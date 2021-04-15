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
                      borderSide:
                      BorderSide(color: Colors.red, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    hintStyle:TextStyle(color: Colors.grey[700]) ,
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
                      borderSide:
                      BorderSide(color: Colors.red, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    hintStyle:TextStyle(color: Colors.grey[700]) ,
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
                      borderSide:
                      BorderSide(color: Colors.red, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    hintStyle:TextStyle(color: Colors.grey[700]) ,
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
                      borderSide:
                      BorderSide(color: Colors.red, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    hintStyle:TextStyle(color: Colors.grey[700]) ,
                    hintText: 'Enter Your Age',
                    labelStyle: TextStyle(color: Colors.red),
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
                ),
                SizedBox(height: 20),
                TextField(
                  onChanged: (value) {
                    diseases = value;
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.red, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    hintStyle:TextStyle(color: Colors.grey[700]) ,
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
                      borderSide:
                      BorderSide(color: Colors.red, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    hintStyle:TextStyle(color: Colors.grey[700]) ,
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
                      style: TextStyle(color: Theme.of(context).backgroundColor, fontWeight: FontWeight.w700),
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
        'contacts': '',
        'diseases': diseases,///TODO: add allergies
        'name': name,
        'imageurl': '',
      });
      Navigator.pushNamed(context, HomePage.id);
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
