import 'package:bizkoala_mobileapp/database/model/item.dart';
import 'package:bizkoala_mobileapp/database/database_helper.dart';

class ItemHelper {
  final DatabaseHelper db = DatabaseHelper.db;
  static const String TABLE = 'items';

  // Item section
  addNew(Item newItem) async {
    final db = await DatabaseHelper.db.database;
    var res = await db.insert(TABLE, newItem.toJson());
    return res;
  }

  getAll() async {
    final db = await DatabaseHelper.db.database;
    var res = await db.query(TABLE, orderBy: 'id DESC');
    var list = res.isNotEmpty ? res.map((q) => Item.fromJson(q)).toList() : [];
    return list;
  }

  getItemByCategoryId(categoryId) async {
    final db = await DatabaseHelper.db.database;
    var res = await db
        .query(TABLE, where: 'category_id = ?', whereArgs: [categoryId]);
    var list = res.isNotEmpty ? res.map((q) => Item.fromJson(q)).toList() : [];
    return list;
  }

  getOne(int id) async {
    final db = await DatabaseHelper.db.database;
    var res = await db.query(TABLE, where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? Item.fromJson(res.first) : null;
  }

  updateOne(Item item) async {
    final db = await DatabaseHelper.db.database;
    var res = await db
        .update(TABLE, item.toJson(), where: 'id = ?', whereArgs: [item.id]);
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
  // End Item section
}
