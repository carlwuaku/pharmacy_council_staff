import 'package:flutter/foundation.dart';
import 'package:pharmacy_council_staff/helpers/database.dart';

class SettingsModel {
  static String tableName = "settings";

  String setting;
  String value;

  SettingsModel({required this.setting, required this.value});

  Future<SettingsModel> getSingleItem(String setting) async {
    // print("getting the data");
    final item = await DBHelper.getItem(SettingsModel.tableName,
        conditions: 'setting = $setting');
    try {
      SettingsModel settingsModel = SettingsModel.fromMap(item);
      return settingsModel;
    } catch (e) {
      rethrow;
    }
  }

  static void addItem(SettingsModel item) async {
    await DBHelper.insert(SettingsModel.tableName, item.toMap());
  }

  //add raw values instead of creating an item from the model
  static void add(String setting, String value) async {
    await DBHelper.insert(
        SettingsModel.tableName, {"setting": setting, "value": value});
    if (kDebugMode) {
      print("item added successfully");
    }
  }

  /// get the value of a setting given the setting name. if no setting is found, a StateError  is thrown from the dbhelper.getitem.
  /// else the value is returned as a string
  static Future<String> getSetting(String setting) async {
    final item = await DBHelper.getItem(SettingsModel.tableName,
        conditions: "setting = '$setting'");
    try {
      //in case no setting was found
      SettingsModel settingsModel = SettingsModel.fromMap(item);

      return settingsModel.value;
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'setting': setting,
      'value': value,
    };
  }

  static SettingsModel fromMap(Map<String, dynamic> item) {
    return SettingsModel(setting: item['setting'], value: item['value']);
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Routine Inspection{name: $setting, license_number: $value,}';
  }
}
