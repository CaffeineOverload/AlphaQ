import 'dart:async';

import 'package:clay_containers/clay_containers.dart';
import 'package:emergency_app/components/ContactsCard.dart';
import 'package:emergency_app/data/data.dart';
import 'package:emergency_app/models/contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';

class ContactsPage extends StatefulWidget {
  static String id = 'ContactsPage';
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  double buttonDepth = 30;

  void _updateContactsList(int index) {
    setState(() {
      HapticFeedback.lightImpact();
      contactslist.removeAt(index);
    });
    ContactsData.updateContactsListInPref(pref);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var baseColor = Theme.of(context).backgroundColor;
    return Scaffold(
      backgroundColor: baseColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Theme.of(context).accentColor,
          ),
          onPressed: () {
            HapticFeedback.lightImpact();
            Navigator.pop(context);
            currentIndex = 0;
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(currentDisplaySize.width * 0.0641),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: currentDisplaySize.height * 0.0355),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Container(
                          child: Text(
                            'Emergency Contacts',
                            overflow: TextOverflow.visible,
                            softWrap: true,
                            style: TextStyle(
                              fontSize: currentDisplaySize.width * 0.1153,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      /// Add Button
                      if (contactslist.length < 5)
                        Hero(
                          tag: 'emergency',
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () async {
                                if (contactslist.length < 5) {
                                  HapticFeedback.lightImpact();
                                  buttonPressed();
                                  try {
                                    await FlutterContactPicker
                                        .requestPermission();
                                    if (await FlutterContactPicker
                                        .hasPermission()) {
                                      PhoneContact contacts =
                                          await FlutterContactPicker
                                              .pickPhoneContact();
                                      ContactsData temp = ContactsData(
                                          name: contacts.fullName,
                                          number: contacts.phoneNumber.number
                                              .toString());
                                      if (!ContactsData.contactIfExist(temp)) {
                                        setState(() {
                                          contactslist.add(temp);
                                        });
                                      }
                                    }
                                  } on Exception catch (_) {
                                    print("throwing new error");
                                    throw Exception("Can't add contacts");
                                  }
                                  ContactsData.updateContactsListInPref(pref);

                                  ///TODO: update data on firebase
                                  updateDetails();
                                }
                              },
                              child: ClayContainer(
                                  color: baseColor,
                                  surfaceColor: baseColor,
                                  depth: buttonDepth.toInt(),
                                  spread: 10,
                                  borderRadius: 100,
                                  height: currentDisplaySize.width * 0.1025,
                                  width: currentDisplaySize.width * 0.1025,
                                  child: Icon(
                                    Icons.add,
                                    size: currentDisplaySize.width * 0.07692,
                                  )),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              ///Contacts List Container
              Expanded(
                flex: 14,
                child: ClayContainer(
                  emboss: true,
                  color: baseColor,
                  surfaceColor: baseColor,
                  depth: 20,
                  borderRadius: 20,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: contactslist.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return ContactsCard(
                              list: contactslist,
                              index: index,
                              update: _updateContactsList,
                            );
                          }),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (contactslist.length > 4)
                      Text("Can't add more than 5 contacts"),
                  ],
                )),
                flex: 1,
              )
            ],
          ),
        ),
      ),
    );
  }

  void buttonPressed() {
    setState(() {
      buttonDepth = 0;
      Timer(Duration(milliseconds: 100), () {
        setState(() {
          buttonDepth = 30;
        });
      });
    });
  }
}
