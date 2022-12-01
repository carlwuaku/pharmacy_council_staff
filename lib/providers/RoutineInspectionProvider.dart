import 'package:flutter/foundation.dart';
import 'package:pharmacy_council_staff/helpers/database.dart';
import 'package:pharmacy_council_staff/models/RoutineInspectionDataModel.dart';
import 'package:pharmacy_council_staff/models/RoutineInspectionModel.dart';

class RoutineInspectionProvider with ChangeNotifier {
  List<RoutineInspectionModel> _inspections = [];
  late Future isInitComplete;

  RoutineInspectionProvider() {
    isInitComplete = fetchData();
  }

  Future<void> fetchData() async {
    final dataList = await DBHelper.getItems(RoutineInspectionModel.table_name);
    _inspections =
        dataList.map((e) => RoutineInspectionModel.fromMap(e)).toList();
    print("getting inspections ${_inspections.length}");
  }

  /// get the data from the database
  ///
  Future<List<RoutineInspectionModel>> getData() async {
    // print("getting the data");
    final dataList = await DBHelper.getItems(RoutineInspectionModel.table_name);
    _inspections =
        dataList.map((e) => RoutineInspectionModel.fromMap(e)).toList();

    return [..._inspections];
  }

  Future<RoutineInspectionModel> getSingleItem(int id) async {
    // print("getting the data");
    final item = await DBHelper.getItem(RoutineInspectionModel.table_name,
        conditions: 'id = $id');
    try {
      RoutineInspectionModel routineInspectionModel =
          RoutineInspectionModel.fromMap(item);
      return routineInspectionModel;
    } catch (e) {
      rethrow;
    }
  }

  List<RoutineInspectionModel> get inspections {
    return [..._inspections];
  }

  void addInspection(RoutineInspectionModel item) async {
    await DBHelper.insert(RoutineInspectionModel.table_name, item.toMap());
    _inspections.add(item);
    notifyListeners();
  }

  /// set the value for a data value.
  /// like the value for the pharmacist present property
  ///
  void setData(RoutineInspectionModel item, RoutineInspectionDataModel dataItem,
      var value) {
    int index =
        item.data.indexWhere((element) => element.label == dataItem.label);

    item.data[index].value = value;
    notifyListeners();
  }

  ///delete some data using their ids
  ///
  void deleteData(List<String> ids) async {
    //join them into a comma-separated list
    String joinedIds = ids.join(",");
    try {
      await DBHelper.deleteByIds(RoutineInspectionModel.table_name, joinedIds);
      _inspections.map((i) => {
            if (ids.contains(i.id.toString())) {_inspections.remove(i)}
          });

      print("after delete, objects length is ${_inspections.length}");
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
// RoutineInspectionModel(
// license_number: 'PC/GR/R/00023',
// name: 'VILGAX PHARMACY',
// date: '2022-02-03',
// data: [
// RoutineInspectionDataModel(
// label: 'Pharmacist Present',
// key: 'pharmacist_present',
// options: [],
// required: true,
// type: 'radio',
// value: 'Yes')
// ]),
// RoutineInspectionModel(
// license_number: 'PC/GR/WR/02383',
// name: 'BEN 10 PHARMACY',
// date: '2022-04-13',
// data: [
// RoutineInspectionDataModel(
// label: 'Floors',
// key: 'floors',
// options: [],
// required: true,
// type: 'radio',
// value: 'Good')
// ]),
// RoutineInspectionModel(
// license_number: 'PC/WR/R/0298J',
// name: 'STAR PHARMACY',
// date: '2022-02-03',
// data: [
// RoutineInspectionDataModel(
// label: 'Ventilation',
// key: 'ventilation',
// options: [],
// required: true,
// type: 'radio',
// value: 'Bad')
// ]),
