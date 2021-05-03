import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/MapModel.dart';

class DatabaseHelper {
  //Create a private constructor
  DatabaseHelper._();

  static const databaseName = 'farmers_database.db';
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database _database;

  Future<Database> get database async {
    if (_database == null) {
      return await initializeDatabase();
    }
    return _database;
  }

  initializeDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), databaseName),
        version: 1, onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE farmers(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, applicantbvn TEXT,applicantfirstname TEXT,applicantmiddlename TEXT, applicantlastname TEXT, applicantgender TEXT, occupation TEXT,maritalstatus TEXT,spousebvn TEXT,address TEXT, city TEXT, lgacode TEXT, lganame TEXT, statecode TEXT, state TEXT, nokbvn TEXT, nokrelationship TEXT, fnpk TEXT,furea TEXT,forganic TEXT,micronutrient TEXT, knapsack TEXT, insecticide TEXT, hlagon TEXT, hnsco TEXT, latitude1 TEXT,longitude1 TEXT, flat TEXT, flong TEXT, hectaredistance TEXT, imageurl TEXT, status TEXT)");
    });
  }

  insertTodo(Mapmodel models) async {
    final db = await database;
    var res = await db.insert(Mapmodel.TABLENAME, models.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return res;
  }

  Future<List<Mapmodel>> retrieveTodos() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(Mapmodel.TABLENAME);

    return List.generate(maps.length, (i) {
      return Mapmodel(
        id: maps[i]['id'],
        name: maps[i]['name'],
        phone: maps[i]['phone'],
        latitude1: maps[i]['latitude1'],
        longitude1: maps[i]['longitude1'],
        flat: maps[i]['flat'],
        flong: maps[i]['flong'],
        hectaredistance: maps[i]['hectaredistance'],
      );
    });
  }

  updateTodo(Mapmodel models) async {
    final db = await database;

    await db.update(Mapmodel.TABLENAME, models.toMap(),
        where: 'id = ?',
        whereArgs: [models.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  deleteTodo(int id) async {
    var db = await database;
    db.delete(Mapmodel.TABLENAME, where: 'id = ?', whereArgs: [id]);
  }
}
