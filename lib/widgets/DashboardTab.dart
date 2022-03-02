import 'package:flutter/material.dart';

class DashboardTab extends StatelessWidget {
  final String label;
  final Function onPress;
  final IconData icon;
  DashboardTab(
      {required this.label, required this.onPress, required this.icon});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        onPress();
      },
      // Navigator.pushNamed(context, RoutineInspectionsScreen.routeName),
      icon: Icon(
        icon,
        color: Theme.of(context).colorScheme.secondary,
        size: 34,
      ),
      label: Text(
        label,
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
      ),
      style: ButtonStyle(
          side: MaterialStateProperty.all(BorderSide(color: Colors.grey))),
    );
  }
}
