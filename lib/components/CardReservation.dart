import 'package:flutter/material.dart';
import 'package:reservations/components/Subtitle.dart';
import 'package:reservations/consts.dart';

class CardReservation extends StatelessWidget {
  final String user;
  final String date;
  final String cancha;
  final Function onPress;

  String dateExtract;

  CardReservation({
    this.user,
    this.date,
    this.cancha,
    this.onPress,
  }) {}

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPress,
        child: Container(
          padding: EdgeInsets.only(bottom: 10, top: 10, left: 20, right: 20),
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(color: kPrimaryColor, width: 1),
          )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Subtitle(cancha),
                    Subtitle(date),
                    Subtitle(user),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.delete_forever_outlined,
                      size: 25.0,
                      color: kdanger,
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
