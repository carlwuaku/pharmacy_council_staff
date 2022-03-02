import 'package:flutter/material.dart';
import 'package:pharmacy_council_staff/screens/RoutineInspectionList.dart';
import 'package:pharmacy_council_staff/widgets/DashboardTab.dart';

class Dashboard extends StatelessWidget {
  static const routeName = "dashboard";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("PCGhana"),
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
                  Text(
                    "Welcome",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "User name here",
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
                  print('pess');
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
    );
  }
}
