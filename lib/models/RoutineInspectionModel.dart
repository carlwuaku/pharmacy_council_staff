import 'dart:convert';

import 'package:pharmacy_council_staff/models/RoutineInspectionDataModel.dart';

class RoutineInspectionModel {
  String license_number;
  String name;
  String date;
  List<RoutineInspectionDataModel> data;
  int id;
  String synced;
  static String table_name = "inspections";

  RoutineInspectionModel(
      {this.license_number = '',
      this.name = '',
      this.date = '',
      required this.data,
      this.id = 0,
      this.synced = 'no'});

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    print(jsonEncode(data).toString());
    return {
      'license_number': license_number,
      'name': name,
      'date': date,
      'data': jsonEncode(data).toString(),
      'synced': synced,
    };
  }

  static RoutineInspectionModel fromMap(Map<String, dynamic> item) {
    List<RoutineInspectionDataModel> data = [];
    try {
      List<dynamic> _data =
          jsonDecode(item['data']); //convert this to List<routine...>

      data = _data.map((item) {
        return RoutineInspectionDataModel.fromJson(
            item as Map<String, dynamic>);
      }).toList();
    } catch (exc) {
      print(exc);
      data = [];
    }
    return RoutineInspectionModel(
        data: data, //jsonDecode(item['data']), //item['data'],
        date: item['date'],
        id: item['id'],
        license_number: item['license_number'],
        name: item['name'],
        synced: item['synced']);
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Routine Inspection{id: $id, name: $name, license_number: $license_number, date: $date, data: ${data.toString()}';
  }
}
