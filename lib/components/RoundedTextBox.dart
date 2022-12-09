import 'package:flutter/material.dart';
import 'package:reservations/consts.dart';

class RoundedTextBox extends StatelessWidget {
  final String text;
  final TextInputType type;
  final bool obscureText;
  final TextEditingController controller;
  final Function validation;

  RoundedTextBox(
      {this.text,
      this.type = TextInputType.text,
      this.obscureText = false,
      this.controller,
      this.validation});

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        keyboardType: type,
        autofocus: false,
        obscureText: obscureText,
        controller: controller,
        validator: validation,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(40.0),
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: kPrimaryColor, width: 1),
            borderRadius: const BorderRadius.all(
              const Radius.circular(40.0),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: kPrimaryColor, width: 1),
            borderRadius: const BorderRadius.all(
              const Radius.circular(40.0),
            ),
          ),
          filled: true,
          fillColor: Colors.white70,
          labelText: text,
          labelStyle: TextStyle(
              backgroundColor: Colors.transparent,
              color: kPrimaryColor,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
    //return TextField(decoration: InputDecoration());
  }
}
