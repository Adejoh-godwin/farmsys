import 'dart:io';
import 'package:path/path.dart';
import '../models/employee_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:farmsys/src/pages/farm/search/bookmodel.dart';

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
    final path = join(documentsDirectory.path, 'farmer_manager.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE farmers(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, applicantbvn TEXT,applicantfirstname TEXT,applicantmiddlename TEXT, applicantlastname TEXT, applicantgender TEXT, occupation TEXT,maritalstatus TEXT,spousebvn TEXT,address TEXT, city TEXT, lgacode TEXT, lganame TEXT, statecode TEXT, state TEXT, nokbvn TEXT, nokrelationship TEXT, fnpk TEXT,furea TEXT,forganic TEXT,micronutrient TEXT, knapsack TEXT, insecticide TEXT, hlagon TEXT, hnsco TEXT, latitude TEXT,longitude TEXT, flat TEXT, flong TEXT, hectaredistance TEXT, imageurl TEXT, status TEXT)");
    });
  }

  // Insert employee on database
  createEmployee(Farmerdata newEmployee) async {
    await deleteAllFarmers();
    final db = await database;
    final res = await db.insert('farmers', newEmployee.toJson());

    return res;
  }

  // Delete all Farmers
  Future<int> deleteAllFarmers() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM farmers');

    return res;
  }

  updateTodo2(Farmerdata models) async {
    final db = await database;
    // ignore: unused_local_variable
    int result1 = 0;
    result1 = await db.update(Farmerdata.TABLENAME, models.toJson(),
        where: 'id = ?',
        whereArgs: [models.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
    final res = await db.rawQuery("SELECT * FROM farmers");
    print(res);
  }

  updateTodoMap(Farmerdata models) async {
    final db = await database;

    await db.update(Farmerdata.TABLENAME, models.toJson2(),
        where: 'id = ?',
        whereArgs: [models.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
    final res = await db.rawQuery("SELECT * FROM farmers");
    print(res);
  }

  Future<List<Farmerdata>> getAllFarmers2() async {
    final db = await database;

    final res = await db.rawQuery("SELECT * FROM farmers");
    print(res);
    List<Farmerdata> list =
        res.isNotEmpty ? res.map((c) => Farmerdata.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<Farmerdata>> getAllFarmersSearch(String query) async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM farmers");
    // List<Farmerdata> list =
    //     res.isNotEmpty ? res.map((c) => Farmerdata.fromJson(c)).toList() : [];

    return res.map((json) => Farmerdata.fromJson(json)).where((book) {
      final titleLower = book.applicantfirstname.toLowerCase();
      final authorLower = book.applicantlastname.toLowerCase();
      final bvn = book.applicantbvn.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower) ||
          bvn.contains(searchLower) ||
          authorLower.contains(searchLower);
    }).toList();
  }

  Future<List<Farmerdata>> getAllFarmersWithId(Farmerdata models) async {
    final db = await database;
    final res =
        await db.rawQuery("SELECT * FROM farmers where id =?", [models.id]);
    print(res);
    List<Farmerdata> list =
        res.isNotEmpty ? res.map((c) => Farmerdata.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<Book>> getBooks(String query) async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM farmers");

    List<Book> list =
        res.isNotEmpty ? res.map((c) => Book.fromJson(c)).toList() : [];
    print(list);
    return list;
  }
}
