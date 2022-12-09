import 'package:flutter/material.dart';
import 'package:reservations/consts.dart';

class Subtitle extends StatelessWidget {
  final String text;
  Subtitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: kPrimaryColor,
        fontSize: 20,
        fontFamily: 'SpaceKids',
      ),
    );
  }
}
