import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper db = DatabaseHelper._();

  static const String DB_NAME = 'bizkoala.db';
  static const String QUOTATION_TABLE = 'quotations';
  static const String CUSTOMER_TABLE = 'customers';

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDb();
    return _database;
  }

  initDb() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, DB_NAME);
    return await openDatabase(path,
        version: 1, onOpen: (db) {}, onCreate: _onbCreate);
  }

  _onbCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $QUOTATION_TABLE ('id' INTEGER PRIMARY KEY, 'title' TEXT, 'note' TEXT, 'tax' TEXT, 'date' TEXT, 'customer_id' INTEGER, 'send' INTEGER)");
    await db.execute(
        "CREATE TABLE $CUSTOMER_TABLE ('id' INTEGER PRIMARY KEY,'name' TEXT, 'email' TEXT, 'address' TEXT, 'telephone' TEXT)");
  }
}
