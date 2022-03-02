import 'package:flutter/material.dart';
import 'package:pharmacy_council_staff/constants.dart';
import 'package:pharmacy_council_staff/models/RoutineInspectionDataModel.dart';
import 'package:pharmacy_council_staff/models/RoutineInspectionModel.dart';
import 'package:pharmacy_council_staff/styles.dart';

class RoutineInspectionDetailsScreen extends StatelessWidget {
  final RoutineInspectionModel routineInspectionModel;

  RoutineInspectionDetailsScreen({required this.routineInspectionModel});

  List<ListTile> parseDetails() {
    List<ListTile> items = [];

    List<RoutineInspectionDataModel> data =
        routineInspectionModel.data; //yields an array of objects [{key:value}]
    for (int i = 0; i < data.length; i++) {
      ListTile card = ListTile(
        title: Text(data[i].key),
        subtitle: Text(data[i].value),
      );
      items.add(card);
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inspection Details"),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            color: Theme.of(context).primaryColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  routineInspectionModel.name,
                  style: kShadowText,
                ),
                Row(
                  children: [
                    Text(
                      routineInspectionModel.license_number,
                      style: whiteTextStyle.copyWith(fontSize: 15),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(routineInspectionModel.date,
                        style: whiteTextStyle.copyWith(fontSize: 15)),
                  ],
                ),
              ],
            ),
          ),
          ...parseDetails()
        ],
      ),
    );
  }
}
