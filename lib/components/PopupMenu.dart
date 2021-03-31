import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


Widget myPopMenu(double width, double height) {
  return PopupMenuButton(
      onSelected: (value) {
        HapticFeedback.selectionClick();
        if(value == 1){
          ///TODO: Direct to maps with Police Stations selected
        }
        if(value == 2){
          ///TODO: Direct to maps with Hospitals selected
        }
      },
    color: Color(0xffEFF2F8),
    child: Container(
      child: Row(
        children: [
          Text(
            'Find Help\nnearby',
            textAlign: TextAlign.right,
            //overflow: TextOverflow.clip,
            style: TextStyle(
              fontSize: width*0.0381,
              fontWeight: FontWeight.w600,
              color: Colors.red[300],
              //fontWeight: FontWeight.bold),
            ),
          ),
          Icon(Icons.location_on_sharp, color: Colors.red, size: height*0.045,)
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
                  child: FaIcon(FontAwesomeIcons.shieldAlt, color: Colors.red,),
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
                  child: FaIcon(FontAwesomeIcons.hospitalAlt, color: Colors.red,),
                ),
                Text('Hospitals')
              ],
            )),
      ]);
}