import 'package:bizkoala_mobileapp/component/drawer.dart';
import 'package:bizkoala_mobileapp/database/database.dart';
import 'package:bizkoala_mobileapp/database/model/quotation.dart';
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
  TextEditingController newTitleController = TextEditingController();

  getNewQuoteTitle() {
    var alertDialog = AlertDialog(
      title: Center(child: Text('New Quotation Title')),
      content: TextField(
        controller: newTitleController,
        textAlign: TextAlign.center,
        decoration:
            InputDecoration(labelText: 'Add a title', hintText: 'Quotation 1'),
        keyboardType: TextInputType.text,
      ),
      actions: <Widget>[
        SizedBox(
          width: double.maxFinite,
          child: RaisedButton(
            color: Colors.green,
            child: Text('Save'),
            onPressed: () {
              addNewQuotation();
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  addNewQuotation() async {
    var newTitle = newTitleController.text;

    List<Quotation> testQuotations = [
      Quotation(
          title: newTitle,
          tax: 10.toString(),
          date: DateTime.now().toString(),
          customerId: 0,
          send: 0),
    ];
    Quotation rnd = testQuotations[0];
    await DBProvider.db.newQuotation(rnd);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title == null ? '' : widget.title),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              })
        ],
      ),
      body: BodyLayout(),
      floatingActionButton: FloatingActionButton(
        elevation: 4.0,
        child: Icon(Icons.add),
        onPressed: () async {
          getNewQuoteTitle();
        },
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

Widget _myListView(BuildContext context) {
  return FutureBuilder(
    future: DBProvider.db.getAllQuotations(),
    builder: (BuildContext context, snapshot) {
      if (snapshot.hasData) {
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            Quotation quotation = snapshot.data[index];
            String quoteId = quotation.id.toString();
            var sendIconColor;
            if (quotation.send == 0) {
              sendIconColor = Colors.blue[600];
            } else {
              sendIconColor = Colors.green[600];
            }
            return ListTile(
              leading: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    width: 30.0,
                    child: IconButton(
                      icon: Icon(
                        Icons.control_point_duplicate,
                        size: 25.0,
                        color: Colors.brown[900],
                      ),
                      onPressed: () {
                        print('Duplicate Quotation #' + quoteId);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 30.0,
                    child: IconButton(
                      icon: Icon(
                        Icons.send,
                        size: 25.0,
                        color: sendIconColor,
                      ),
                      onPressed: () {
                        print('Send Quotation #' + quoteId + ' to anyone');
                      },
                    ),
                  ),
                  SizedBox(
                    width: 30.0,
                    child: IconButton(
                      icon: Icon(
                        Icons.delete_forever,
                        size: 25.0,
                        color: Colors.brown[900],
                      ),
                      onPressed: () {
                        print('Delete Quotation #' + quoteId);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 30.0,
                    child: IconButton(
                      icon: Icon(
                        Icons.file_download,
                        size: 25.0,
                        color: Colors.brown[900],
                      ),
                      onPressed: () {
                        print('Download Quotation #' + quoteId);
                      },
                    ),
                  ),
                ],
              ),
              onTap: () {
                print('Edit Quotation #' + quoteId);
                Navigator.pushNamed(context, '/update-quotation');
              },
              title: Text(
                quotation.title,
                style: new TextStyle(fontWeight: FontWeight.normal),
              ),
            );
          },
        );
      } else {
        return Center(child: CircularProgressIndicator());
      }
    },
  );
}
