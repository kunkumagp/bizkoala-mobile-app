import 'package:bizkoala_mobileapp/database/model/quotation.dart';
import 'package:bizkoala_mobileapp/database/database_helper.dart';

class QuotationHelper {
  final DatabaseHelper db = DatabaseHelper.db;
  static const String TABLE = 'quotations';

  addNew(Quotation newQuotation) async {
    final db = await DatabaseHelper.db.database;
    var res = await db.insert(TABLE, newQuotation.toJson());
    // var res = await db.rawInsert(
    //     "INSERT Into quotations (title, send)"
    //     " VALUES (?,?)",
    //     [newQuotation.title, newQuotation.send.toString()]);
    return res;
  }

  getAll() async {
    final db = await DatabaseHelper.db.database;
    var res = await db.query(TABLE, orderBy: 'id DESC');
    var list =
        res.isNotEmpty ? res.map((q) => Quotation.fromJson(q)).toList() : [];
    return list;
  }

  getOne(int id) async {
    final db = await DatabaseHelper.db.database;
    var res = await db.query(TABLE, where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? Quotation.fromJson(res.first) : null;
  }

  updateOne(Quotation quotation) async {
    final db = await DatabaseHelper.db.database;
    var res = await db.update(TABLE, quotation.toJson(),
        where: 'id = ?', whereArgs: [quotation.id]);
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
}
