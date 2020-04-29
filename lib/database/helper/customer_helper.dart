import 'package:bizkoala_mobileapp/database/model/customers.dart';
import 'package:bizkoala_mobileapp/database/database_helper.dart';

class CustomerHelper {
  final DatabaseHelper db = DatabaseHelper.db;
  static const String TABLE = 'customers';

  // Customer section
  newCustomer(Customer newCustomer) async {
    final db = await DatabaseHelper.db.database;
    var res = await db.insert(TABLE, newCustomer.toJson());
    return res;
  }

  getAllCustomers() async {
    final db = await DatabaseHelper.db.database;
    var res = await db.query(TABLE, orderBy: 'id DESC');
    List<Customer> list =
        res.isNotEmpty ? res.map((q) => Customer.fromJson(q)).toList() : [];
    return list;
  }

  getCustomer(int id) async {
    final db = await DatabaseHelper.db.database;
    var res = await db.query(TABLE, where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? Customer.fromJson(res.first) : null;
  }

  updateCustomer(Customer customer) async {
    final db = await DatabaseHelper.db.database;
    var res = await db.update(TABLE, customer.toJson(),
        where: 'id = ?', whereArgs: [customer.id]);
    return res;
  }

  deleteAllCustomers() async {
    final db = await DatabaseHelper.db.database;
    db.delete(TABLE);
  }

  deleteCustomer(int id) async {
    final db = await DatabaseHelper.db.database;
    db.delete(TABLE, where: 'id = ?', whereArgs: [id]);
  }
  // End Customer section
}
