import 'package:farmsys/model/Kin.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
          "CREATE TABLE farmers(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, phone TEXT, boa TEXT,gender TEXT,lga TEXT,location TEXT,state TEXT,ward TEXT, cooperative TEXT, dob TEXT, kinname TEXT, kinphone TEXT, kindob TEXT, kinrelationship TEXT, kinaddress TEXT, fnpk TEXT,furea TEXT,forganic TEXT,micronutrient TEXT, knapsack TEXT, insecticide TEXT, hlagon TEXT, hnsco TEXT, latitude1 TEXT,longitude1 TEXT, flat TEXT, flong TEXT, hectaredistance TEXT, imageurl TEXT, status TEXT)");
    });
  }

  insertTodo(Kinmodel kmodels) async {
    final db = await database;
    var res = await db.insert(Kinmodel.TABLENAME, kmodels.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return res;
  }

  Future<List<Kinmodel>> retrieveTodos() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(Kinmodel.TABLENAME);

    return List.generate(maps.length, (i) {
      return Kinmodel(
        id: maps[i]['id'],
        name: maps[i]['name'],
        phone: maps[i]['phone'],
        kinname: maps[i]['kinname'],
        kinphone: maps[i]['kinphone'],
        kindob: maps[i]['kindob'],
        kinrelationship: maps[i]['kinrelationship'],
        kinaddress: maps[i]['kinaddress'],
      );
    });
  }

  updateTodo(Kinmodel kmodels) async {
    final db = await database;

    await db.update(Kinmodel.TABLENAME, kmodels.toMap(),
        where: 'id = ?',
        whereArgs: [kmodels.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  deleteTodo(int id) async {
    var db = await database;
    db.delete(Kinmodel.TABLENAME, where: 'id = ?', whereArgs: [id]);
  }
}
