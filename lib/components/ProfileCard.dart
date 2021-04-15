import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    @required this.height,
  @required this.title,
  @required this.icon,
    @required this.editmode,
    @required this.controller,
    @required this.onChanged,
  });

  final double height;
  final String title;
  final FaIcon icon;
  final bool editmode;
  final TextEditingController controller;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          padding: EdgeInsets.all(10),
          //height: 200,
          //width: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                  overflow: TextOverflow.visible,
                  softWrap: true,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: height*0.0201
                  ),),
                icon,
              ],
            ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextField(
                  autofocus: false,
                  textAlign: TextAlign.left,
                  readOnly: editmode ? false : true,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: height*0.0301
                  ),
                  keyboardType: TextInputType.name,
                  //textInputAction: TextInputAction.continueAction,
                  controller: controller,
                  onChanged: onChanged/*(value) {
                    setState(() {
                      //controller.text = value;
                      name = value;
                    });
                  }*/,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter $title',
                    hintStyle: TextStyle(
                        fontSize: height * 0.0186,
                        fontWeight: FontWeight.w500),
                  ),
                ),/*Text(value,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: height*0.0301
                  ),),*/
              ),],
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Theme.of(context).dividerColor, width: 1)
          ),
        ),
      ),
    );
  }
}
