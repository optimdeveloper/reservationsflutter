import 'package:flutter/material.dart';
import 'package:reservations/components/Subtitle.dart';
import 'package:reservations/consts.dart';

class AlertDialogCard extends StatelessWidget {
  final String user;
  final String date;
  final String cancha;
  final Function onPress;

  String dateExtract;

  AlertDialogCard({
    this.user,
    this.date,
    this.cancha,
    this.onPress,
  }) {}

  @override
  Widget build(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Alert Dialog Box"),
        content: const Text("You have raised a Alert Dialog Box"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Container(
              color: Colors.green,
              padding: const EdgeInsets.all(14),
              child: const Text("okay"),
            ),
          ),
        ],
      ),
    );
  }
}
