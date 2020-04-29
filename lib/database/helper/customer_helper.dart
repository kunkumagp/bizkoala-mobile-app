import 'package:bizkoala_mobileapp/database/model/customer.dart';
import 'package:bizkoala_mobileapp/database/database_helper.dart';

class CustomerHelper {
  final DatabaseHelper db = DatabaseHelper.db;
  static const String TABLE = 'customers';

  // Customer section
  addNew(Customer newCustomer) async {
    final db = await DatabaseHelper.db.database;
    var res = await db.insert(TABLE, newCustomer.toJson());
    return res;
  }

  getAll() async {
    final db = await DatabaseHelper.db.database;
    var res = await db.query(TABLE, orderBy: 'id DESC');
    List<Customer> list =
        res.isNotEmpty ? res.map((q) => Customer.fromJson(q)).toList() : [];
    return list;
  }

  getOne(int id) async {
    final db = await DatabaseHelper.db.database;
    var res = await db.query(TABLE, where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? Customer.fromJson(res.first) : null;
  }

  updateOne(Customer customer) async {
    final db = await DatabaseHelper.db.database;
    var res = await db.update(TABLE, customer.toJson(),
        where: 'id = ?', whereArgs: [customer.id]);
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
  // End Customer section
}
