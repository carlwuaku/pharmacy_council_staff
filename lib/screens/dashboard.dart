import 'package:flutter/material.dart';
import 'package:pharmacy_council_staff/constants.dart';
import 'package:pharmacy_council_staff/screens/RoutineInspectionList.dart';
import 'package:pharmacy_council_staff/widgets/DashboardTab.dart';
import 'package:pharmacy_council_staff/widgets/LogoutButton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  static const routeName = "dashboard";

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String userDisplayName = "";

  void getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userDisplayName = prefs.getString(kUserDisplayName)!;
    });
  }

  @override
  void initState() {
    getUserName();
  }

  Future<bool> confirmExit() async {
    return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Exit app"),
              content: Text("Do you want to exit app?"),
              actions: [
                OutlinedButton(
                  child: Text("No"),
                  onPressed: () => {},
                ),
                OutlinedButton(
                  child: Text("Yes"),
                  onPressed: () => {},
                )
              ],
            ));
  }

  void logout() {}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: confirmExit,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("PCGhana"),
          actions: [LogoutButton()],
        ),
        body: ListView(
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Welcome",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      userDisplayName,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
            GridView.count(
              primary: false,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: <Widget>[
                DashboardTab(
                  label: "Routine Inspections",
                  onPress: () {
                    Navigator.pushNamed(
                        context, RoutineInspectionListScreen.routeName);
                  },
                  icon: Icons.build,
                ),
                DashboardTab(
                  label: "View Phamacy Details",
                  onPress: () {},
                  icon: Icons.business,
                ),
                DashboardTab(
                  label: "Pharmacy Coordinates",
                  onPress: () {},
                  icon: Icons.location_on_outlined,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
