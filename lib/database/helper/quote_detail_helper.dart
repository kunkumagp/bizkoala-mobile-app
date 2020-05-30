import 'package:bizkoala_mobileapp/database/model/quote_detail.dart';
import 'package:bizkoala_mobileapp/database/database_helper.dart';

class QuoteDetailHelper {
  final DatabaseHelper db = DatabaseHelper.db;
  static const String TABLE = 'quote_details';
  static const String SECOND_TABLE = 'items';

  // QuoteDetail section
  addNew(QuoteDetail newQuoteDetail) async {
    final db = await DatabaseHelper.db.database;
    var res = await db.insert(TABLE, newQuoteDetail.toJson());
    return res;
  }

  // getAll() async {
  //   final db = await DatabaseHelper.db.database;
  //   var res = await db.query(TABLE, orderBy: 'id DESC');
  //   // var res = await db.rawQuery(
  //   //     'SELECT * FROM $TABLE INNER JOIN items ON basket.id = items.basketId');
  //   var list =
  //       res.isNotEmpty ? res.map((q) => QuoteDetail.fromJson(q)).toList() : [];
  //   return list;
  // }

  getAllByQuoteId(quoteId) async {
    final db = await DatabaseHelper.db.database;
    var res = await db.rawQuery(
        "SELECT * FROM $TABLE INNER JOIN $SECOND_TABLE ON $TABLE.item_id = $SECOND_TABLE.id AND $TABLE.quote_id='" +
            quoteId +
            "'");
    var list =
        res.isNotEmpty ? res.map((q) => QuoteDetail.fromJson(q)).toList() : [];
    return list;
  }

  getOne(int id) async {
    final db = await DatabaseHelper.db.database;
    var res = await db.query(TABLE, where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? QuoteDetail.fromJson(res.first) : null;
  }

  updateOne(QuoteDetail quoteDetail) async {
    final db = await DatabaseHelper.db.database;
    var res = await db.update(TABLE, quoteDetail.toJson(),
        where: 'id = ?', whereArgs: [quoteDetail.id]);
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
  // End QuoteDetail section
}
