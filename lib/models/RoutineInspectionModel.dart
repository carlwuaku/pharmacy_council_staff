import 'package:pharmacy_council_staff/models/RoutineInspectionDataModel.dart';

class RoutineInspectionModel {
  String license_number;
  String name;
  String date;
  List<RoutineInspectionDataModel> data;

  RoutineInspectionModel(
      {this.license_number = '',
      this.name = '',
      this.date = '',
      required this.data});
}
