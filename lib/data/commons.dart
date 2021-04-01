import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void showError(BuildContext context, final e) {
  String error = '';
  int i = 0;
  final er = e.toString();
  while (i < er.length && er[i] != ']') i++;
  i += 2;
  while (i < er.length) {
    error += er[i];
    i++;
  }
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
