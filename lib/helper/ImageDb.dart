import 'package:farmsys/model/Imagemodel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/Imagemodel.dart';

class DatabaseHelper2 {
  //Create a private constructor
  DatabaseHelper2._();

  static const databaseName = 'farmers_database.db';
  static final DatabaseHelper2 instance = DatabaseHelper2._();
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
          "CREATE TABLE farmers(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, phone TEXT, boa TEXT,gender TEXT,lga TEXT,location TEXT,state TEXT,ward TEXT, cooperative TEXT, dob TEXT, kinname TEXT, kinphone TEXT, kindob TEXT, kinrelationship TEXT, kinaddress TEXT, fnpk TEXT,furea TEXT,forganic TEXT,micronutrient TEXT, knapsack TEXT, insecticide TEXT, hlagon TEXT, hnsco TEXT, latitude1 TEXT,longitude1 TEXT, flat TEXT, flong TEXT, hectaredistance TEXT, imageurl TEXT, status TEXT)");
    });
  }

  insertTodo(Imagemodel images) async {
    final db = await database;
    var res = await db.insert(Imagemodel.TABLENAME, images.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return res;
  }

  Future<List<Imagemodel>> retrieveTodos() async {
    final db = await database;

    final List<Map<String, dynamic>> maps =
        await db.query(Imagemodel.TABLENAME);

    return List.generate(maps.length, (i) {
      return Imagemodel(id: maps[i]['id'], imageurl: maps[i]['imageurl']);
    });
  }

  updateTodo(Imagemodel images) async {
    final db = await database;

    await db.update(Imagemodel.TABLENAME, images.toMap(),
        where: 'id = ?',
        whereArgs: [images.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  deleteTodo(int id) async {
    var db = await database;
    db.delete(Imagemodel.TABLENAME, where: 'id = ?', whereArgs: [id]);
  }
}
