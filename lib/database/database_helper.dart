import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper db = DatabaseHelper._();

  static const String DB_NAME = 'bizkoala.db';

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
        "CREATE TABLE currencies ('id' INTEGER PRIMARY KEY, 'country' TEXT, 'currency' TEXT, 'code' TEXT, 'symbol' TEXT)");
    await db.execute(
        "CREATE TABLE categories ('id' INTEGER PRIMARY KEY, 'parent_id' INTEGER, 'name' TEXT, 'label' TEXT, 'details' LONGTEXT)");
    await db.execute(
        "CREATE TABLE customers ('id' INTEGER PRIMARY KEY,'name' TEXT, 'email' TEXT, 'address' TEXT, 'telephone' TEXT)");
    await db.execute(
        "CREATE TABLE items ('id' INTEGER PRIMARY KEY, 'categoryId' INTEGER, 'code' TEXT, 'name' TEXT, 'price' TEXT, 'details' TEXT, 'isActivy' TEXT)");
    await db.execute(
        "CREATE TABLE profile ('id' INTEGER PRIMARY KEY, 'systemId' INTEGER, 'currency_id' INTEGER, 'email' TEXT, 'company_name' TEXT, 'address' TEXT, 'telephone' TEXT, 'logo' TEXT)");
    await db.execute(
        "CREATE TABLE quotations ('id' INTEGER PRIMARY KEY, 'title' TEXT, 'note' TEXT, 'tax' TEXT, 'date' TEXT, 'customer_id' INTEGER, 'send' INTEGER)");
    await db.execute(
        "CREATE TABLE quote_details ('id' INTEGER PRIMARY KEY, 'quote_id' INTEGER, 'item_id' INTEGER, 'price' TEXT, 'quantity' INTEGER)");
  }
}
