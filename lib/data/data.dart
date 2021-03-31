import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
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



  factory ContactsData.fromJson(Map<String, dynamic> jsonData) {
    return ContactsData(
      name: jsonData['name'],
      number: jsonData['number'],
    );
  }

  static Map<String, dynamic> toMap(ContactsData contactsData) => {
    'name': contactsData.name,
    'number': contactsData.number,
  };

  static String encode(List<ContactsData> contactsDatas) => json.encode(
    contactsDatas
        .map<Map<String, dynamic>>((contactsData) => ContactsData.toMap(contactsData))
        .toList(),
  );

  static List<ContactsData> decode(String contactsDatas) =>
      (json.decode(contactsDatas) as List<dynamic>)
          .map<ContactsData>((item) => ContactsData.fromJson(item))
          .toList();

  static void updateContactsListInPref(SharedPreferences pref){
    String temp = encode(contactslist);
    pref.setString('contactsData', temp);
  }
}

class ProfileData{
  String bloodGroup;
  int age;
  String otherMedicalIssues;

  ProfileData({this.bloodGroup, this.age, this.otherMedicalIssues});
}


DisplaySize currentDisplaySize = DisplaySize();

List<ContactsData> contactslist = [];

String contactsData;

SharedPreferences pref;

