import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar(
      {this.size = 50,
      @required this.image}
      );
final double size;
final AssetImage image;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: image,
          ),
          //shape: BoxShape.rectangle,
          color: Color(0xffc7c9cd)
      ),
    );
  }
}