import 'package:crypt/crypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pharmacy_council_staff/screens/dashboard.dart';

import '../constants.dart';

class ConfirmPinForm extends StatefulWidget {
  @override
  _ConfirmPinFormState createState() => _ConfirmPinFormState();
}

class _ConfirmPinFormState extends State<ConfirmPinForm> {
  FlutterSecureStorage storage = FlutterSecureStorage();
  TextEditingController pinController = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  bool error = false;
//todo: add error for when pin is incorect,
  //todo: add reset pin
  void confirmPin() async {
    setState(() {
      error = false;
    });

    String? storedHashedPassword = await storage.read(key: kUserPin);
    if (storedHashedPassword != null) {
      if (Crypt(storedHashedPassword).match(pinController.text)) {
        //a match. move to the dashboard

        Navigator.pushNamed(context, Dashboard.routeName);
      } else {
        // show wrong pin and clear it
        setState(() {
          error = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _form,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(kEnterPinText),
              Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(kTextFieldBorderRadius),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: pinController,
                    textAlign: TextAlign.center,
                    textInputAction: TextInputAction.done,
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
                        fillColor: Colors.white,
                        errorStyle: kErrorTextStyle),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              if (error) const Text(kPinWrong),
              const SizedBox(
                height: 20,
              ),
              TextButton.icon(
                onPressed: () {
                  if (_form.currentState!.validate()) {
                    confirmPin();
                  }
                },
                icon: const Icon(Icons.arrow_right_alt_sharp),
                label: const Text('Submit'),
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
