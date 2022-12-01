import 'package:crypt/crypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pharmacy_council_staff/screens/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class CreatePinForm extends StatefulWidget {
  const CreatePinForm({Key? key}) : super(key: key);

  @override
  _CreatePinFormState createState() => _CreatePinFormState();
}

class _CreatePinFormState extends State<CreatePinForm> {
  //fields: pin, confirm pin
  //on form submit, submit tto the database and set the
  //shared preferences. then navigate to the dashboard
  TextEditingController pinController = TextEditingController();
  TextEditingController pinConfirmController = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  void setPin() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    String hashed = Crypt.sha256(pinController.text).toString();
    storage.write(key: kUserPin, value: hashed);
    //update the shared prefs
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(kUserPin, "yes");
    //show toast and navigate to the dashboard
    const snackBar = SnackBar(content: Text(kPinSetMessage));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.pushNamed(context, Dashboard.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _form,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(kTextFieldBorderRadius),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: pinController,
                    textAlign: TextAlign.center,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      //value has to be exactly 4 chars
                      if (value?.length != 4) {
                        return '4 Characters required for the PIN';
                      }
                      return null;
                    },
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    decoration: kTextFieldDecorator.copyWith(
                        labelText: "Enter a 4-digit PIN",
                        filled: true,
                        fillColor: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(kTextFieldBorderRadius),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: pinConfirmController,
                    textAlign: TextAlign.center,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      //value has to be exactly 4 chars
                      if (value != pinController.text) {
                        return 'Please make sure the PINs match';
                      }
                      return null;
                    },
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    decoration: kTextFieldDecorator.copyWith(
                        labelText: "Enter PIN again",
                        filled: true,
                        fillColor: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton.icon(
                onPressed: () {
                  if (_form.currentState!.validate()) {
                    setPin();
                  }
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
        ));
  }
}
