import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pharmacy_council_staff/widgets/confirmPin.dart';
import 'package:pharmacy_council_staff/widgets/createPinForm.dart';
import 'package:pharmacy_council_staff/widgets/userProfile.dart';

import '../constants.dart';

class UserPinScreen extends StatefulWidget {
  static String routeName = "userpin";
  @override
  _UserPinScreenState createState() => _UserPinScreenState();
}

class _UserPinScreenState extends State<UserPinScreen> {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  late String username;
  @override
  void initState() {
    super.initState();
    //check for the user pin. if set in the db,ask user to confirm it. else ask user to create it

    //TODO: add forgot pin
  }

  Future<bool> checkUserPinSet() async {
    String pin = "";
    try {
      //if a setting was found and no error thrown, then it's true. else false
      var store = await storage.read(key: kUserPin);
      return store != null;
    } on StateError {
      //it has not been set
      return false;
    } catch (error) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: SafeArea(
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              child: Center(
                child: ListView(
                  children: [
                    const UserProfile(),
                    const SizedBox(
                      height: 15,
                    ),
                    FutureBuilder(
                        future: checkUserPinSet(),
                        builder: (BuildContext context,
                            AsyncSnapshot<bool> snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data == true) {
                              return Card(
                                  color: Colors.white,
                                  elevation: 2.0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 8.0),
                                    child: ConfirmPinForm(),
                                  ));
                              //todo: create the form to confirm the pin

                            } else {
                              return CreatePinForm();
                            }
                          } else if (snapshot.hasError) {
                            return Text("There was an error. Please try again");
                            //todo: add a button to try again or report
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                  ],
                ),
              )),
        ));
  }
}
