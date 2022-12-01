import 'package:flutter/material.dart';
import 'package:pharmacy_council_staff/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          //show dialog to ask if to logout. then remove the username and id from the db
          final bool result = await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Logout"),
                  content: Text("Are you sure you want to logout"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Yes'),
                    ),
                  ],
                );
              });
          print(result);
          if (result) {
            //clear the sharedprefs, and navigate to the login
            final sharedPrefs = await SharedPreferences.getInstance();
            sharedPrefs.clear();
            Navigator.pushNamed(context, LoginScreen.routeName);
          }
        },
        icon: Icon(Icons.logout));
  }
}
