import 'package:flutter/material.dart';

int currentIndex = 0;

class DisplaySize{
  double height;
  double width;
  DisplaySize({this.height, this.width});
}

class ContactsData{
  String name;
  String number;

  ContactsData({this.name, this.number});
}

class ProfileData{
  String bloodGroup;
  int age;
  String otherMedicalIssues;

  ProfileData({this.bloodGroup, this.age, this.otherMedicalIssues});
}


DisplaySize currentDisplaySize = DisplaySize();

List<ContactsData> contactslist = [
  ContactsData(name: 'Harsh Malvi',number: '9386504938'),
  ContactsData(name: 'Krishna Patel',number: '9387042837'),
  ContactsData(name: 'Deep Rodge',number: '7016821780'),
];

