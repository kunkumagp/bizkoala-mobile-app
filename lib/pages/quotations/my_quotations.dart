import 'package:bizkoala_mobileapp/component/drawer.dart';
import 'package:bizkoala_mobileapp/database/helper/quotation_helper.dart';
import 'package:bizkoala_mobileapp/database/model/quotation.dart';
import 'package:bizkoala_mobileapp/service/app_services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

final appService = AppService();

class MyQuotations extends StatefulWidget {
  MyQuotations({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyQuotationsState createState() => _MyQuotationsState();
}

class _MyQuotationsState extends State<MyQuotations> {
  TextEditingController newTitleController = TextEditingController();
  TextEditingController editTitleController = TextEditingController();
  bool _duplicateCustomerDetails = true;
  bool _duplicateItems = true;

  newQuoteDialogBox() async {
    var alertDialog = AlertDialog(
      title: Center(child: Text('New Quotation Title')),
      content: TextField(
        autofocus: true,
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
              newTitleController.clear();
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
    await QuotationHelper().addNew(rnd);
    setState(() {});
  }

  duplicateDialogBox(quotation) async {
    editTitleController.text = 'Copy - ' + quotation.title;
    var oldQuoteId = quotation.id;

    var alertDialog = AlertDialog(
      title: TextField(
        autofocus: true,
        controller: editTitleController,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.text,
      ),
      content: Container(
        constraints: BoxConstraints(maxHeight: 130.0),
        child: Column(
          children: <Widget>[
            CheckboxListTile(
              title: Text("Duplicate Customer Details"),
              value: _duplicateCustomerDetails,
              onChanged: (newValue) {
                checkBoxChange('customer', quotation);
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: Text("Duplicate Item Quotation"),
              value: _duplicateItems,
              onChanged: (newValue) {
                checkBoxChange('item', quotation);
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        SizedBox(
          width: double.maxFinite,
          child: RaisedButton(
            color: Colors.green,
            child: Text('Create'),
            onPressed: () {
              duplicateQuotation(oldQuoteId, editTitleController,
                  _duplicateCustomerDetails, _duplicateItems);
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

  checkBoxChange(field, quotation) async {
    setState(() {
      if (field == "customer") {
        if (_duplicateCustomerDetails == false) {
          _duplicateCustomerDetails = true;
        } else if (_duplicateCustomerDetails == true) {
          _duplicateCustomerDetails = false;
        }
      } else if (field == "item") {
        if (_duplicateItems == false) {
          _duplicateItems = true;
        } else if (_duplicateItems == true) {
          _duplicateItems = false;
        }
      }
    });
    Navigator.of(context).pop(); // Line 1
    duplicateDialogBox(quotation);
  }

  duplicateQuotation(oldQuoteId, newTitle, customerDetails, itemDetails) async {
    var oldQuotation = await QuotationHelper().getOne(oldQuoteId);
    int customerId;

    customerDetails == true
        ? customerId = oldQuotation.customerId
        : customerId = null;

    // itemDetails == true
    //     ? customerId = oldQuotation.customerId
    //     : customerId = null;

    Quotation newQuote = Quotation(
        title: newTitle.text,
        tax: oldQuotation.tax,
        date: oldQuotation.date,
        customerId: customerId,
        send: 0);
    Quotation rnd = newQuote;
    await QuotationHelper().addNew(rnd);
    setState(() {});
    Navigator.pop(context);
    showWebColoredToast("Quotation duplicated successfully.", 'success');
  }

  deleteQuotation(id, title) async {
    var text = RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          fontSize: 14.0,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(text: 'This will permanently delete the '),
          TextSpan(text: title, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(
                'Are you sure?',
                textAlign: TextAlign.center,
              ),
              content: Text(
                'This will permanently delete the ' + title.toString() + ' !.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.0),
              ),
              actions: <Widget>[
                FlatButton(
                    color: Colors.red,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(8.0),
                    splashColor: Colors.blueAccent,
                    onPressed: () {
                      QuotationHelper().deleteOne(id);
                      setState(() {});
                      Navigator.pop(context);
                    },
                    child: Text('yes')),
                FlatButton(
                    color: Colors.grey,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(8.0),
                    splashColor: Colors.blueAccent,
                    onPressed: () {
                      setState(() {});
                      Navigator.pop(context);
                    },
                    child: Text('no')),
              ],
            ));
  }

  showWebColoredToast(msg, type) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: null,
        textColor: Colors.white,
        fontSize: 16.0);
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
      body: FutureBuilder(
        future: QuotationHelper().getAll(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData && snapshot.data.length > 0) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Quotation quotation = snapshot.data[index];
                int quoteId = quotation.id;
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
                            duplicateDialogBox(quotation);
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
                            print('Send Quotation #' +
                                quoteId.toString() +
                                ' to anyone');
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
                            print('Delete Quotation #' + quoteId.toString());
                            deleteQuotation(quoteId, quotation.title);
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
                            print('Download Quotation #' + quoteId.toString());
                          },
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    print('Edit Quotation #' + quoteId.toString());
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
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Text("No Quotations...")],
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 4.0,
        icon: Icon(Icons.add),
        label: Text("Add New Quotation"),
        onPressed: () async {
          newQuoteDialogBox();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      drawer: MyDrawer(widget.title),
    );
  }
}
