// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_council_staff/constants.dart';
import 'package:pharmacy_council_staff/helpers/network.dart';
import 'package:pharmacy_council_staff/models/SettingsModel.dart';
import 'package:pharmacy_council_staff/widgets/LogoHero.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dashboard.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  late Future isLoggedIn;
  @override
  void initState() {
    super.initState();
    isLoggedIn = checkUserState();
  } //check if the user details have been set already

  Future<void> checkUserState() async {
    try {
      String userId = await SettingsModel.getSetting(kUserIdKey);
      String userDisplayName = await SettingsModel.getSetting(kUserDisplayName);

      ///if the details have not been set, go to login. if they are set, check the pin.
      ///if the pin is set, ask user to enter it. if no pin is set as user to create one
      print(userId);
      if (userId.isNotEmpty) {
        //navigate to dashboard
        setUserDetails(userDisplayName, userId);
        Navigator.pushNamed(context, Dashboard.routeName);
      }
    } on Exception {
      if (kDebugMode) {
        print(Exception);
      }
    }
  }

  void setUserDetails(String username, String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(kUserDisplayName, username);
    await prefs.setString(kUserIdKey, userId);
  }

  void doLogin() async {
    Map<String, dynamic> data = {
      "username": usernameController.text,
      "password": passwordController.text
    };
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Please wait")
                ],
              ),
            ),
          );
        });

    //  make network call with user credentials
    //  if successful, navigate to the dashboard. else display notification
    try {
      final response =
          await Network.postData("api_admin/inspectionAppLogin", data);
      if (response.statusCode == 200) {
        // final
        final body = jsonDecode(response.body);
        switch (body['status']) {
          case '1':
            final userData = body['user_data'];
            String userId = userData['id'];
            String userDisplayName = userData['display_name'];

            //save the user details in the database
            SettingsModel.add(kUserIdKey, userId);
            SettingsModel.add(kUserDisplayName, userDisplayName);

            setUserDetails(userDisplayName, userId);
            //close the dialog
            Navigator.of(context).pop();

            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Login Successful."),
            ));
            Navigator.pushNamed(context, Dashboard.routeName);
            //we use the return here to prevent the final Navigation.pop() from being called as this overides the dashboard
            //navigation above
            return;
          default:
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(body['message']),
            ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Server error. Try again"),
        ));
      }
    } on SocketException {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Network error. Try again"),
      ));
    } on Exception {
      if (kDebugMode) {
        print(Exception);
      }
    } finally {
      //close the dialog
      Navigator.of(context).pop();
    }
  }

  void setPin() async {
    //check if the database has the pin setting value inserted. if not create it
    try {
      String pin = await SettingsModel.getSetting(kUserPin);
      if (kDebugMode) {
        print(pin);
      }
    } on Exception {
      if (kDebugMode) {
        print(Exception);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 20, bottom: 8),
          child: Column(
            children: [
              Flexible(
                child: LogoHero(
                  height: kLogoHeight,
                ),
              ),
              const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              ),
              FutureBuilder(
                future: isLoggedIn,
                builder: (context, snapshot) => snapshot.connectionState ==
                        ConnectionState.waiting
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            "Login",
                            textAlign: TextAlign.center,
                            style: kShadowText,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Form(
                              key: _form,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Material(
                                      borderRadius: BorderRadius.circular(
                                          kTextFieldBorderRadius),
                                      elevation: 3,
                                      child: TextFormField(
                                        controller: usernameController,
                                        autofocus: true,
                                        textAlign: TextAlign.center,
                                        decoration:
                                            kTextFieldDecorator.copyWith(
                                          hintText: 'Username',
                                          prefixIcon: const Icon(
                                            Icons.person,
                                            color: Colors.black38,
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                        ),
                                        textInputAction: TextInputAction.next,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'This field is required';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Material(
                                      borderRadius: BorderRadius.circular(
                                          kTextFieldBorderRadius),
                                      elevation: 3,
                                      child: TextFormField(
                                          controller: passwordController,
                                          textInputAction: TextInputAction.done,
                                          textAlign: TextAlign.center,
                                          obscureText: true,
                                          decoration:
                                              kTextFieldDecorator.copyWith(
                                            hintText: 'Password',
                                            prefixIcon: const Icon(
                                              Icons.lock,
                                              color: Colors.black38,
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                          ),
                                          onFieldSubmitted: (val) {
                                            doLogin();
                                          },
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'This field is required';
                                            }
                                            return null;
                                          }),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextButton.icon(
                                      onPressed: () {
                                        //login here
                                        if (_form.currentState!.validate()) {
                                          doLogin();
                                        }
                                      },
                                      icon: const Icon(
                                          Icons.arrow_right_alt_sharp),
                                      label: const Text('Login'),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .secondary),
                                          elevation:
                                              MaterialStateProperty.all(0),
                                          foregroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.white),
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap),
                                    )
                                  ],
                                ),
                              )),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Row(
// children: [
// Icon(Icons.person),
// TextField(
// decoration: InputDecoration(labelText: 'username'),
// ),
// ],
// ),
// SizedBox(
// height: 20,
// ),
