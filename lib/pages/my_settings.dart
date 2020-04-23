import 'package:bizkoala_mobileapp/component/drawer.dart';
import 'package:flutter/material.dart';
import 'package:bizkoala_mobileapp/service/app_services.dart';

final appService = AppService();

class Settings extends StatefulWidget {
  Settings({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 15.0),
            child: RaisedButton(
              elevation: 2.0,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                  side: BorderSide(color: Colors.white)),
              onPressed: () {
                appService.isLoggedIn().then((value) {
                  print(value);
                });
              },
              color: Colors.white,
              textColor: Colors.green,
              child: Text("done".toUpperCase(), style: TextStyle(fontSize: 14)),
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text(widget.title)],
        ),
      ),
      drawer: MyDrawer(widget.title),
    );
  }
}
