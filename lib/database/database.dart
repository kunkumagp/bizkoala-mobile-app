import 'dart:async';
import 'dart:io' as io;
import 'package:bizkoala_mobileapp/database/model/quotation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static const String DB_NAME = 'bizkoala.db';
  static const String QUOTATION_TABLE = 'quotations';

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
  }

// Add
  newQuotation(Quotation newQuotation) async {
    final db = await database;
    var res = await db.insert(QUOTATION_TABLE, newQuotation.toJson());
    // var res = await db.rawInsert(
    //     "INSERT Into quotations (title, send)"
    //     " VALUES (?,?)",
    //     [newQuotation.title, newQuotation.send.toString()]);
    return res;
  }

// Get

  getAllQuotations() async {
    final db = await database;
    var res = await db.query(QUOTATION_TABLE, orderBy: 'id DESC');
    List<Quotation> list =
        res.isNotEmpty ? res.map((q) => Quotation.fromJson(q)).toList() : [];
    return list;
  }

  getQuotation(int id) async {
    final db = await database;
    var res = await db.query(QUOTATION_TABLE, where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? Quotation.fromJson(res.first) : null;
  }

  // Update
  updateQuotation(Quotation newQuotation) async {
    final db = await database;
    var res = await db.update(QUOTATION_TABLE, newQuotation.toJson(),
        where: 'id = ?', whereArgs: [newQuotation.id]);
    return res;
  }

  // Delete
  deleteAllQuotations() async {
    final db = await database;
    db.delete(QUOTATION_TABLE);
  }

  deleteQuotation(int id) async {
    final db = await database;
    db.delete(QUOTATION_TABLE, where: 'id = ?', whereArgs: [id]);
  }
}
