import 'dart:io';
import 'package:farmsys/model/newModel.dart';
import 'package:farmsys/src/src/models/employee_model.dart';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // If database don't exists, create one
    _database = await initDB();

    return _database;
  }

  // Create the database and the Employee table
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'employee_manager.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE farmers(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, phone TEXT, gender TEXT,lga TEXT,location TEXT,state TEXT, lga TEXT)");
    });
  }

  // Insert employee on database
  createEmployee(Studentdata newEmployee) async {
    await deleteAllEmployees();
    final db = await database;
    final res = await db.insert('farmers', newEmployee.toJson());

    return res;
  }

  // Delete all employees
  Future<int> deleteAllEmployees() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM farmers');

    return res;
  }

  Future<List<Studentdata>> getAllEmployees() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM farmers");

    List<Studentdata> list =
        res.isNotEmpty ? res.map((c) => Studentdata.fromJson(c)).toList() : [];
    print(list);
    return list;
  }

  Future<List<Farmerdata>> getAllEmployees2() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM farmers");

    List<Farmerdata> list =
        res.isNotEmpty ? res.map((c) => Farmerdata.fromJson(c)).toList() : [];
    print(list);
    return list;
  }
}
