import 'package:emergency_app/data/commons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ForgetPass extends StatefulWidget {
  static String id = 'ForgetPass';
  @override
  _ForgetPassState createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  @override
  String email;
  bool showSpinner = false;
  String notice = "Please enter Your email.";
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        progressIndicator: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.red),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                notice,
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
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
                    sendmail();
                    //Navigator.pushNamed(context, RegisterPage.id);
                  },
                  child: Text(
                    "Send Link",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void sendmail() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Alert(
          context: context,
          type: AlertType.success,
          title: 'Link Sent',
          desc: 'Reset Link sent to your mail.',
          buttons: [
            DialogButton(
              child: Text('Okay'),
              onPressed: () => Navigator.pop(context),
              width: 120,
              color: Colors.red,
            )
          ]).show();
    } catch (e) {
      // TODO
      showError(context, e);
    }
    setState(() {
      showSpinner = false;
    });
  }
}
