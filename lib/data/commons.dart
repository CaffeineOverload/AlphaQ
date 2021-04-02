import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void showError(BuildContext context, final e) {
  String error = '';
  if (e.code == 'wrong-password')
    error = 'Please enter correct password';
  else if (e.code == 'user-not-found')
    error = 'No user found for given email';
  else if (e.code == 'email-already-in-use')
    error = 'Email is already registered with us';
  Alert(
      context: context,
      type: AlertType.error,
      title: 'Error',
      desc: '$error',
      buttons: [
        DialogButton(
          child: Text('Okay'),
          onPressed: () => Navigator.pop(context),
          width: 120,
          color: Colors.red,
        )
      ]).show();
}
