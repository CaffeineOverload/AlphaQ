import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

Widget myPopMenu(double width, double height, BuildContext context) {
  return PopupMenuButton(
      onSelected: (value) async {
        HapticFeedback.selectionClick();
        if (value == 1) {
          if (await canLaunch(
              'https://www.google.com/maps/dir/?api=1&destination=Police')) {
            await launch(
                'https://www.google.com/maps/dir/?api=1&destination=Police');
          } else {
            throw 'Could not open the map.';
          }
        }
        if (value == 2) {
          if (await canLaunch(
              'https://www.google.com/maps/dir/?api=1&destination=Hospital')) {
            await launch(
                'https://www.google.com/maps/dir/?api=1&destination=Hospital');
          } else {
            throw 'Could not open the map.';
          }
        }
      },
      color: Theme.of(context).backgroundColor,
      child: Container(
        //color: Theme.of(context).backgroundColor,
        child: Row(
          children: [
            Text(
              'Find Help\nnearby',
              textAlign: TextAlign.right,
              //overflow: TextOverflow.clip,
              style: TextStyle(
                fontSize: width * 0.0381,
                fontWeight: FontWeight.w600,
                color: Colors.red[300],
                //fontWeight: FontWeight.bold),
              ),
            ),
            Icon(
              Icons.location_on_sharp,
              color: Colors.red,
              size: height * 0.045,
            )
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      itemBuilder: (context) => [
            PopupMenuItem(
                value: 1,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2, 2, 12, 2),
                      child: FaIcon(
                        FontAwesomeIcons.shieldAlt,
                        color: Colors.red,
                      ),
                    ),
                    Text('Police Stations')
                  ],
                )),
            PopupMenuItem(
                value: 2,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2, 2, 10, 2),
                      child: FaIcon(
                        FontAwesomeIcons.hospitalAlt,
                        color: Colors.red,
                      ),
                    ),
                    Text('Hospitals')
                  ],
                )),
          ]);
}
