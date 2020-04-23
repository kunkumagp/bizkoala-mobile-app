import 'package:shared_preferences/shared_preferences.dart';
// Replace these two methods in the examples that follow

class AppService {
  Future isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final authToken = prefs.getString('authToken');
    if (authToken == null) {
      return false;
    }
    return true;
  }

  Future logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', null);
  }

  Future login() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', 'token_1');
  }
}
