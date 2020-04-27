import 'package:bizkoala_mobileapp/component/drawer.dart';
import 'package:flutter/material.dart';
import 'package:bizkoala_mobileapp/service/app_services.dart';

final appService = AppService();

class UpdateQuotations extends StatefulWidget {
  UpdateQuotations({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _UpdateQuotationState createState() => _UpdateQuotationState();
}

class _UpdateQuotationState extends State<UpdateQuotations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
