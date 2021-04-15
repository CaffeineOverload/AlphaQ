import 'package:emergency_app/data/commons.dart';
import 'package:emergency_app/data/data.dart';
import 'package:emergency_app/pages/HomePage.dart';
import 'package:emergency_app/pages/Register.dart';
import 'package:emergency_app/pages/forgetpass.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  static final id = 'Login';
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  String Email;
  String Password;
  bool showSpinner = false;
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
              shrinkWrap: true,
              children: [
                TextField(
                  controller: emailController,
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
                    labelText: 'Email',
                    hintStyle:TextStyle(color: Colors.grey[700]) ,
                    hintText: 'Enter Your Email',
                    labelStyle: TextStyle(color: Colors.red),
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
                  controller: passController,
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
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: FlatButton(
                          onPressed: () async {
                            setState(() {
                              showSpinner = true;
                            });
                            _getuser();
                            setState(() {
                              showSpinner = false;
                            });
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(color: Theme.of(context).backgroundColor, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: FlatButton(
                          onPressed: () {
                            Navigator.pushNamed(context, RegisterPage.id);
                            ///TODO: get details user details(disease, allergies etc) from firebase and store in pref
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(color: Theme.of(context).backgroundColor, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ForgetPass.id);
                  },
                  child: Text(
                    'Forget Password?',
                    style: TextStyle(color: Colors.red),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getuser() async {
    try {
      currentUser = await _auth.signInWithEmailAndPassword(
          email: Email, password: Password);
      print(currentUser);
      SharedPreferences.getInstance().then((prefs) {
        email = Email;
        password = Password;
        prefs.setString('email', Email);
        prefs.setString('password', Password);
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
}
