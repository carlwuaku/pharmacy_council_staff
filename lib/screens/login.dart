// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:pharmacy_council_staff/constants.dart';
import 'package:pharmacy_council_staff/screens/dashboard.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 20, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo512white.png'),
                  ),
                ),
              ),
              SizedBox(
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
              Flexible(
                child: Material(
                  borderRadius: BorderRadius.circular(kTextFieldBorderRadius),
                  elevation: 3,
                  child: TextField(
                    autofocus: true,
                    textAlign: TextAlign.center,
                    decoration: kTextFieldDecorator.copyWith(
                      hintText: 'Username',
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.black38,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Material(
                borderRadius: BorderRadius.circular(kTextFieldBorderRadius),
                elevation: 3,
                child: TextField(
                  textAlign: TextAlign.center,
                  obscureText: true,
                  decoration: kTextFieldDecorator.copyWith(
                    hintText: 'Password',
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.black38,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, Dashboard.routeName);
                },
                icon: const Icon(Icons.arrow_right_alt_sharp),
                label: const Text('Login'),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.secondary),
                    elevation: MaterialStateProperty.all(0),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap),
              )
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
