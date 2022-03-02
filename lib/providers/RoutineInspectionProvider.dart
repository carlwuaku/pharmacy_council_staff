import 'package:flutter/foundation.dart';
import 'package:pharmacy_council_staff/models/RoutineInspectionDataModel.dart';
import 'package:pharmacy_council_staff/models/RoutineInspectionModel.dart';

class RoutineInspectionProvider extends ChangeNotifier {
  List<RoutineInspectionModel> _inspections = [
    RoutineInspectionModel(
        license_number: 'PC/GR/R/00023',
        name: 'VILGAX PHARMACY',
        date: '2022-02-03',
        data: [
          RoutineInspectionDataModel(
              label: 'Pharmacist Present',
              key: 'pharmacist_present',
              options: [],
              required: true,
              type: 'radio',
              value: 'Yes')
        ]),
    RoutineInspectionModel(
        license_number: 'PC/GR/WR/02383',
        name: 'BEN 10 PHARMACY',
        date: '2022-04-13',
        data: [
          RoutineInspectionDataModel(
              label: 'Floors',
              key: 'floors',
              options: [],
              required: true,
              type: 'radio',
              value: 'Good')
        ]),
    RoutineInspectionModel(
        license_number: 'PC/WR/R/0298J',
        name: 'STAR PHARMACY',
        date: '2022-02-03',
        data: [
          RoutineInspectionDataModel(
              label: 'Ventilation',
              key: 'ventilation',
              options: [],
              required: true,
              type: 'radio',
              value: 'Bad')
        ]),
  ];

  List<RoutineInspectionModel> get inspections {
    return _inspections;
  }

  void addInspection(RoutineInspectionModel item) {
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
}
