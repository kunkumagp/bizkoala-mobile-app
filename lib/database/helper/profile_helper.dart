import 'package:bizkoala_mobileapp/database/model/profile.dart';
import 'package:bizkoala_mobileapp/database/database_helper.dart';

class ProfileHelper {
  final DatabaseHelper db = DatabaseHelper.db;
  static const String TABLE = 'profile';

  // Profile section
  addNew(Profile newProfile) async {
    final db = await DatabaseHelper.db.database;
    var res = await db.insert(TABLE, newProfile.toJson());
    return res;
  }

  getAll() async {
    final db = await DatabaseHelper.db.database;
    var res = await db.query(TABLE, orderBy: 'id DESC');
    List<Profile> list =
        res.isNotEmpty ? res.map((q) => Profile.fromJson(q)).toList() : [];
    return list;
  }

  getOne(int id) async {
    final db = await DatabaseHelper.db.database;
    var res = await db.query(TABLE, where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? Profile.fromJson(res.first) : null;
  }

  updateOne(Profile profile) async {
    final db = await DatabaseHelper.db.database;
    var res = await db.update(TABLE, profile.toJson(),
        where: 'id = ?', whereArgs: [profile.id]);
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
  // End Profile section
}
