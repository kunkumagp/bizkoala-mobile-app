import 'package:bizkoala_mobileapp/database/model/currency.dart';
import 'package:bizkoala_mobileapp/database/database_helper.dart';

class CurrencyHelper {
  final DatabaseHelper db = DatabaseHelper.db;
  static const String TABLE = 'currencies';

  // Currency section
  addNew(Currency newCurrency) async {
    final db = await DatabaseHelper.db.database;
    var res = await db.insert(TABLE, newCurrency.toJson());
    return res;
  }

  getAll() async {
    final db = await DatabaseHelper.db.database;
    var res = await db.query(TABLE, orderBy: 'id DESC');
    List<Currency> list =
        res.isNotEmpty ? res.map((q) => Currency.fromJson(q)).toList() : [];
    return list;
  }

  getOne(int id) async {
    final db = await DatabaseHelper.db.database;
    var res = await db.query(TABLE, where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? Currency.fromJson(res.first) : null;
  }

  updateOne(Currency currency) async {
    final db = await DatabaseHelper.db.database;
    var res = await db.update(TABLE, currency.toJson(),
        where: 'id = ?', whereArgs: [currency.id]);
    return res;
  }

  deleteAll() async {
    final db = await DatabaseHelper.db.database;
    db.delete(TABLE);
  }

  deleteOne(int id) async {
    final db = await DatabaseHelper.db.database;
    db.delete(TABLE, where: 'id = ?', whereArgs: [id]);
  }
  // End Currency section
}
