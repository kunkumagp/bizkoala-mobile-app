import 'package:bizkoala_mobileapp/component/drawer.dart';
import 'package:bizkoala_mobileapp/database/helper/customer_helper.dart';
import 'package:bizkoala_mobileapp/database/model/customer.dart';
import 'package:bizkoala_mobileapp/service/app_services.dart';
import 'package:flutter/material.dart';

final appService = AppService();

class MyCustomers extends StatefulWidget {
  MyCustomers({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyCustomerState createState() => _MyCustomerState();
}

class _MyCustomerState extends State<MyCustomers> {
  TextEditingController newCustomerNameController = TextEditingController();
  TextEditingController newCustomerEmailController = TextEditingController();
  TextEditingController newCustomerAddressController = TextEditingController();
  TextEditingController newCustomerTelephoneController =
      TextEditingController();

  newCustomerDialogBox() async {
    var alertDialog = AlertDialog(
      title: Center(child: Text('Add New Customer')),
      content: Container(
          alignment: Alignment.topCenter,
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  autofocus: true,
                  controller: newCustomerNameController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      labelText: 'Name', hintText: 'John Watson'),
                  keyboardType: TextInputType.text,
                ),
                TextField(
                  controller: newCustomerEmailController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      labelText: 'E-mail', hintText: 'johnwatson@gmail.com'),
                  keyboardType: TextInputType.text,
                ),
                TextField(
                  controller: newCustomerTelephoneController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      labelText: 'Telephone No',
                      hintText: '(0044) 12 345 6789'),
                  keyboardType: TextInputType.text,
                ),
                TextField(
                  controller: newCustomerAddressController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      labelText: 'Address',
                      hintText: '221B, Baker Street, London.'),
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                ),
              ],
            ),
          )),
      actions: <Widget>[
        SizedBox(
          width: double.maxFinite,
          child: RaisedButton(
            color: Colors.green,
            child: Text('Save'),
            onPressed: () {
              addNewCustomer();
              Navigator.pop(context);
              newCustomerNameController.clear();
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

  addNewCustomer() async {
    var newName = newCustomerNameController.text;
    var newEmail = newCustomerEmailController.text;
    var newAddress = newCustomerAddressController.text;
    var newTelephone = newCustomerTelephoneController.text;

    var newCustomers = Customer(
      name: newName,
      email: newEmail,
      address: newAddress,
      telephone: newTelephone,
    );
    Customer rnd = newCustomers;
    await CustomerHelper().addNew(rnd);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: CustomerHelper().getAll(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData && snapshot.data.length > 0) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Customer customer = snapshot.data[index];
                int customerId = customer.id;
                return ListTile(
                  onTap: () {
                    print('Edit Customer #' + customerId.toString());
                    Navigator.pushNamed(context, '/update-quotation');
                  },
                  title: Text(
                    customer.name,
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
        label: Text("Add New Customer"),
        onPressed: () async {
          newCustomerDialogBox();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      drawer: MyDrawer(widget.title),
    );
  }
}
