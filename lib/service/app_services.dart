import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

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

  showToast(msg, type) {
    var bgColor;
    var textColor;
    if (type == 'success') {
      bgColor = null;
      textColor = Colors.white;
    }
    if (type == 'error') {
      bgColor = Colors.red;
      textColor = Colors.white;
    }
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: bgColor,
        textColor: textColor,
        fontSize: 16.0);
  }

  onLoading(context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: 300.0,
            height: 200.0,
            alignment: AlignmentDirectional.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: SizedBox(
                    height: 50.0,
                    width: 50.0,
                    child: CircularProgressIndicator(
                      value: null,
                      strokeWidth: 7.0,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 25.0),
                  child: Center(
                    child: Text(
                      "loading.. wait...",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
