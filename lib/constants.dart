import 'package:flutter/material.dart';

const kAppTitle = "Pharmacy Council";
const kUserIdKey = "USER_ID";
const kUserNameKey = "USERNAME";
const kUserDisplayName = "USER_DISPLAY_NAME";
const kTextFieldBorderRadius = 2.0;
const kUserPin = "USER_PIN";
const kHeroLogoTag = 'logo';
const kBackgroundColor = Colors.lightBlueAccent;
const kLogoHeight = 200.0;
const kErrorTextStyle =
    TextStyle(color: Colors.red, fontStyle: FontStyle.italic);
const kShadowText = TextStyle(shadows: [
  Shadow(color: Colors.black38, blurRadius: 2, offset: Offset(1, 1))
], color: Colors.white, fontSize: 25);

const highlightedTextStyle = TextStyle(color: Colors.blue);

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

String cpid = "";
const kPinSetMessage = "PIN set successfully";
const kPinWrong = "The PIN entered is incorrect. Please try again";
const kEnterPinText = "Enter your PIN";
