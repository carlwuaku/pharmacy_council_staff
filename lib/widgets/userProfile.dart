import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  // final String name;
  // final String email;
  // final String imageUrl;

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String userDisplayName = '';

  void getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userDisplayName = prefs.getString(kUserDisplayName)!;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserName();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      userDisplayName,
      style: kShadowText,
    );
  }
}
