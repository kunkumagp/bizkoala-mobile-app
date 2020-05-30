import 'package:bizkoala_mobileapp/database/model/category.dart';
import 'package:bizkoala_mobileapp/database/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class CategoryHelper {
  final DatabaseHelper db = DatabaseHelper.db;
  static const String TABLE = 'categories';

  // Category section
  addNew(Category newCategory) async {
    final db = await DatabaseHelper.db.database;
    var res = await db.insert(TABLE, newCategory.toJson());
    return res;
  }

  getAll() async {
    final db = await DatabaseHelper.db.database;
    var res = await db.query(TABLE, orderBy: 'id DESC');
    List<Category> list =
        res.isNotEmpty ? res.map((q) => Category.fromJson(q)).toList() : [];
    return list;
  }

  categoryCount() async {
    final db = await DatabaseHelper.db.database;
    var x = await db.rawQuery('SELECT COUNT (*) from $TABLE');
    int count = Sqflite.firstIntValue(x);
    return count;
  }

  getOne(int id) async {
    final db = await DatabaseHelper.db.database;
    var res = await db.query(TABLE, where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? Category.fromJson(res.first) : null;
  }

  updateOne(Category category) async {
    final db = await DatabaseHelper.db.database;
    var res = await db.update(TABLE, category.toJson(),
        where: 'id = ?', whereArgs: [category.id]);
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
  // End Category section
}
