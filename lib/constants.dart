import 'package:flutter/material.dart';

const kAppTitle = "Pharmacy Council";
const kTextFieldBorderRadius = 2.0;

const kShadowText = TextStyle(shadows: [
  Shadow(color: Colors.black38, blurRadius: 2, offset: Offset(1, 1))
], color: Colors.white, fontSize: 25);

const kTextFieldDecorator = InputDecoration(
  hintText: '',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(2.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(width: 0.0, color: Colors.grey),
    // borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 0.5),
    // borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
