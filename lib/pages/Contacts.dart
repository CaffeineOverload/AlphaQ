import 'dart:async';

import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:emergency_app/components/ContactsCard.dart';
import 'package:emergency_app/data/data.dart';
//import 'package:fluttercontactpicker/fluttercontactpicker.dart';


class ContactsPage extends StatefulWidget {
  static String id = 'ContactsPage';
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  double buttonDepth = 30;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    print(height);
    double width = MediaQuery.of(context).size.width;
    print(width);
    var baseColor = Colors.white;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(width * 0.0641),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(bottom: height * 0.0355),
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
                              fontSize: width * 0.1153,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      /// Add Button
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () async {
                            buttonPressed();
                            /*final granted = await FlutterContactPicker.requestPermission();
                            if (await FlutterContactPicker.hasPermission()) {
                              PhoneContact contacts =
                                  await FlutterContactPicker.pickPhoneContact();
                              setState(() {


                              contactslist.add(ContactsData(
                                  name: contacts.fullName,
                                  number: contacts.phoneNumber.toString()));
                              });
                            }*/
                          },
                          child: ClayContainer(
                              color: baseColor = Colors.white,
                              depth: buttonDepth.toInt(),
                              spread: 10,
                              borderRadius: 100,
                              height: width * 0.1025,
                              width: width * 0.1025,
                              child: Icon(
                                Icons.add,
                                size: width * 0.07692,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              ///Contacts List Container
              Expanded(
                flex: 7,
                child: ClayContainer(
                  emboss: true,
                  color: baseColor,
                  depth: 20,
                  borderRadius: 20,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: contactslist.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return ContactsCard(data: contactslist[index]);
                        }),
                  ),
                ),
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
