import 'package:bizkoala_mobileapp/component/drawer.dart';
import 'package:flutter/material.dart';
import 'package:bizkoala_mobileapp/service/app_services.dart';

final appService = AppService();

class MyQuotations extends StatefulWidget {
  MyQuotations({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyQuotationsState createState() => _MyQuotationsState();
}

class _MyQuotationsState extends State<MyQuotations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title == null ? '' : widget.title),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.person), onPressed: () {})
        ],
      ),
      body: BodyLayout(),
      floatingActionButton: FloatingActionButton(
        elevation: 4.0,
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      drawer: MyDrawer(widget.title),
    );
  }
}

class BodyLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _myListView(context);
  }
}

// replace this function with the code in the examples
Widget _myListView(BuildContext context) {
  // backing data
  final quotationList = [
    'Quotation 1',
    'Quotation 2',
    'Quotation 3',
    'Quotation 4',
    'Quotation 5',
    'Quotation 6',
    'Quotation 7',
    'Quotation 8',
  ];

  quotationList.sort((b, a) => a.compareTo(b));
  quotationList.addAll({'test'});

  return ListView.builder(
    itemCount: quotationList.length,
    itemBuilder: (context, index) {
      return ListTile(
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: 30.0,
              child: IconButton(
                icon: Icon(
                  Icons.control_point_duplicate,
                  size: 20.0,
                  color: Colors.brown[900],
                ),
                onPressed: () {},
              ),
            ),
            SizedBox(
              width: 30.0,
              child: IconButton(
                icon: Icon(
                  Icons.send,
                  size: 20.0,
                  color: Colors.brown[900],
                ),
                onPressed: () {},
              ),
            ),
            SizedBox(
              width: 30.0,
              child: IconButton(
                icon: Icon(
                  Icons.delete_forever,
                  size: 20.0,
                  color: Colors.brown[900],
                ),
                onPressed: () {},
              ),
            ),
            SizedBox(
              width: 30.0,
              child: IconButton(
                icon: Icon(
                  Icons.file_download,
                  size: 20.0,
                  color: Colors.brown[900],
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
        title: Text(
          quotationList[index],
          style: new TextStyle(fontWeight: FontWeight.normal),
        ),
      );
    },
  );
}
