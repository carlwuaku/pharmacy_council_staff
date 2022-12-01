import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_council_staff/constants.dart';
import 'package:pharmacy_council_staff/models/SettingsModel.dart';
import 'package:pharmacy_council_staff/screens/login.dart';
import 'package:pharmacy_council_staff/widgets/LogoHero.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'UserPin.dart';
import 'dashboard.dart';

class Welcome extends StatefulWidget {
  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  void initState() {
    super.initState();
    checkUserState();
  }

  //check if the user details have been set already
  void checkUserState() async {
    try {
      print("checking usersate");
      String userId = "";
      try {
        userId = await SettingsModel.getSetting(kUserIdKey);
      } on StateError {
        //the setting was not found
      }
      String userDisplayName = "";
      try {
        userDisplayName = await SettingsModel.getSetting(kUserDisplayName);
      } on StateError {
        //the setting was not found
      }
      // String userPin = "";
      // try{
      //   userPin = await SettingsModel.getSetting(kUserPin);
      // }
      // on StateError{
      //   //the setting was not found
      // }
      final prefs = await SharedPreferences.getInstance();

      ///if the details have not been set, go to login. if they are set, check the pin.
      ///if the pin is set, ask user to enter it. if no pin is set ask user to create one
      bool isPinSet = false;
      if (prefs.getString(kUserPin) != null &&
          prefs.getString(kUserPin) != "") {
        isPinSet = true;
      }

      // print(userId);
      if (userId.isEmpty) {
        //navigate to login if userid is empty

        Navigator.pushNamed(context, LoginScreen.routeName);
      } else if (isPinSet) {
        //if the pin had been set and the user id is also set, go to the dashboard
        setUserDetails(userDisplayName, userId);
        Navigator.pushNamed(context, Dashboard.routeName);
      } else {
        setUserDetails(userDisplayName, userId);
        //if the pin is not set, and user id is set
        Navigator.pushNamed(context, UserPinScreen.routeName);
      }
      //navigate
    } catch (exc) {
      if (kDebugMode) {
        print(exc);
      }
    }
  }

  void setUserDetails(String username, String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(kUserDisplayName, username);
    await prefs.setString(kUserIdKey, userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 20, bottom: 8),
          child: Center(
            child: Column(
              children: const [
                Flexible(
                  child: LogoHero(
                    height: kLogoHeight,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Flexible(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
