import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:emergency_app/models/contacts.dart';

int currentIndex = 0;

class DisplaySize{
  double height;
  double width;
  DisplaySize({this.height, this.width});
}


class ProfileData{
  String bloodGroup;
  int age;
  String otherMedicalIssues;

  ProfileData({this.bloodGroup, this.age, this.otherMedicalIssues});
}


DisplaySize currentDisplaySize = DisplaySize();

String name;

List<ContactsData> contactslist = [];

String contactsData;

SharedPreferences pref;

