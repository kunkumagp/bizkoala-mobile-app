import 'package:bizkoala_mobileapp/component/drawer.dart';
import 'package:flutter/material.dart';

class ProductServices extends StatefulWidget {
  ProductServices({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _ProductServicesState createState() => _ProductServicesState();
}

class _ProductServicesState extends State<ProductServices> {
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
