import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:pharmacy_council_staff/models/RoutineInspectionModel.dart';
import 'package:pharmacy_council_staff/models/SettingsModel.dart';
import 'package:pharmacy_council_staff/models/UsersModel.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Map<int, String> migrations = {
    1: '''
    CREATE TABLE IF NOT EXISTS ${RoutineInspectionModel.table_name} (id INTEGER PRIMARY KEY, name TEXT, license_number TEXT,
         data Text, date Text, synced TEXT);
         CREATE TABLE pharmacies (id INTEGER PRIMARY KEY, name TEXT, license_number TEXT, data TEXT);
    ''',
    2: '''
    CREATE TABLE IF NOT EXISTS ${UsersModel.tableName} (id INTEGER PRIMARY KEY, displayName TEXT, email TEXT);
    ''',
    3: ''' 
        CREATE TABLE IF NOT EXISTS ${SettingsModel.tableName} (id INTEGER PRIMARY KEY, setting TEXT, value TEXT);
    ''',
    4: '''
    ALTER TABLE ${UsersModel.tableName} ADD COLUMN pin TEXT DEFAULT NULL
    '''
  };

  static Future<Database> getConnection() async {
    int migrationCount = migrations.length;
    // print(migrationCount);
    Database database = await openDatabase(
        // Set the path to the database. Note: Using the `join` function from the
        // `path` package is best practice to ensure the path is correctly
        // constructed for each platform.
        join(await getDatabasesPath(), 'pcghana.db'),
        onCreate: (database, version) async {
      // Run the CREATE TABLE statement on the database.
      for (int i = 1; i <= migrationCount; i++) {
        await database.execute(migrations[i]!);
      }
    }, onUpgrade: (database, oldVersion, newVersion) async {
      for (int i = oldVersion; i <= newVersion; i++) {
        try {
          await database.execute(migrations[i]!);
          print("$i migrated");
        } catch (exc) {
          print("$i $exc");
        }
      }
    }, version: migrationCount);
    return database;
  }

  static Future<void> insert(String table, Map<String, dynamic> data) async {
    final db = await getConnection();

    // Insert the item into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    try {
      await db.insert(
        table,
        data,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      if (kDebugMode) {
        print("inserted successfully");
      }
    } catch (exc) {
      if (kDebugMode) {
        print(exc);
      }
      if (kDebugMode) {
        print("not inserted ");
      }
    }
  }

  static Future<List<Map<String, dynamic>>> getItems(String table,
      {String conditions = ' 1 ', int limit = 10000, int offset = 0}) async {
    final db = await getConnection();
    // Query the table for some items.
    final List<Map<String, dynamic>> maps =
        await db.query(table, where: conditions, limit: limit, offset: offset);
    //return the list and convert it to whatever the consuming class needs
    return maps;
  }

  /// get a single item matching some conditions
  /// returns a map<string, dynamic> if an object is found, throws an exception
  static Future<Map<String, dynamic>> getItem(String table,
      {String conditions = ' 1 ', int limit = 10000, int offset = 0}) async {
    final db = await getConnection();
    print(conditions);
    try {
      // Query the table for some items.
      final List<Map<String, dynamic>> maps = await db.query(table,
          where: conditions, limit: limit, offset: offset);

      //return the first item of the list and convert it to whatever the consuming class needs
      //in case nothing was found, throw a StateError
      return maps.first;
    } catch (e) {
      if (kDebugMode) print('error in database get item $e');
      rethrow;
    }
  }

  ///delete some items based on their ids (comma-separated)
  ///
  static Future<void> deleteByIds(String table, String ids) async {
    final db = await getConnection();
    print(ids);
    try {
      await db.delete(table, where: "id in ('$ids')");
    } catch (e) {
      rethrow;
    }
  }
}
