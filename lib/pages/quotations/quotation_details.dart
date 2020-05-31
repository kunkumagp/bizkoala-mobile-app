import 'package:bizkoala_mobileapp/database/helper/item_helper.dart';
import 'package:bizkoala_mobileapp/database/model/item.dart';
import 'package:flutter/material.dart';
import 'package:bizkoala_mobileapp/service/app_services.dart';
import 'package:bizkoala_mobileapp/database/helper/quote_detail_helper.dart';
import 'package:bizkoala_mobileapp/database/model/quote_detail.dart';

final appService = AppService();
List itemList = [];
List quoteItemList = [];

class QuotationDetails extends StatefulWidget {
  QuotationDetails({Key key, this.data}) : super(key: key);
  final data;
  @override
  _QuotationDetailState createState() => _QuotationDetailState();
}

class _QuotationDetailState extends State<QuotationDetails> {
  double iconSize = 40;
  @override
  Widget build(BuildContext context) {
    final quotationId = widget.data['id'];
    final quotationTitle = widget.data['title'];
    setItemToArray(quotationId);

    return Scaffold(
      appBar: AppBar(
        title: Text(quotationTitle),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {},
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          ItemList(quotationId),
          DataTable(
            columns: [
              DataColumn(
                label: Container(
                  height: 80,
                  margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: FlatButton(
                    color: Colors.blueAccent,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(8.0),
                    onPressed: () {
                      AppService().onLoading(context);
                      Future.delayed(Duration(seconds: 1), () {
                        Navigator.pop(context); //pop dialog
                        Navigator.pushNamed(context, '/add-quotation-items',
                            arguments: {
                              'id': quotationId,
                              'title': quotationTitle,
                            });
                      });
                    },
                    child: Text('Add New Item'),
                  ),
                ),
              ),
              DataColumn(label: Text('')),
              DataColumn(label: Text('')),
            ],
            rows: [
              DataRow(cells: [
                DataCell(Container(width: 100, child: Text('Sub Total'))),
                DataCell(Text('')),
                DataCell(
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text('3500.00'),
                  ),
                ),
              ]),
              DataRow(cells: [
                DataCell(Text('Tax')),
                DataCell(Text('10%')),
                DataCell(
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text('350.00'),
                  ),
                ),
              ]),
              DataRow(cells: [
                DataCell(Text(
                  'Total',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                )),
                DataCell(Text('')),
                DataCell(
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '3850.00',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                  ),
                ),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}

// setItemToArray() {
//   print(QuoteDetailHelper().getAllByQuoteId(1));
// }

Future setItemToArray(quoteId) async {
  var result = await ItemHelper().getAll();
  for (var i = 0; i < result.length; i++) {
    var resultMap = {
      'id': result[i].id,
      'price': result[i].price,
      'name': result[i].name,
    };
    itemList.add(resultMap);
  }
}

class ItemList extends StatelessWidget {
  int quoteId;
  ItemList(this.quoteId);
  @override
  Widget build(context) {
    return FutureBuilder(
      future: QuoteDetailHelper().getAllByQuoteId(quoteId),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data.length > 0) {
          List list = snapshot.data;

          for (var i = 0; i < list.length; i++) {
            var a = list[i];
            for (var o = 0; o < itemList.length; o++) {
              var b = itemList[o];
              if (a.itemId == b['id']) {
                var resultMap = {
                  'itemId': a.itemId,
                  'lineTotal': a.price,
                  'quantity': a.quantity,
                  'name': b['name'],
                };
                quoteItemList.add(resultMap);
              }
            }
          }

          return DataTable(
            columns: [
              DataColumn(label: Text('Product')),
              DataColumn(label: Text('Qty')),
              DataColumn(
                label: Container(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  alignment: Alignment.centerRight,
                  child: Text('Line Total'),
                ),
              ),
            ],
            rows: quoteItemList
                .map(
                  ((element) => DataRow(
                        cells: <DataCell>[
                          DataCell(Container(
                              width: 130, child: Text(element['name']))),
                          DataCell(Text(element['quantity'].toString())),
                          DataCell(
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text(element['lineTotal']),
                            ),
                          ),
                        ],
                      )),
                )
                .toList(),
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ListTile(
                  title: Text(
                    "No Items...",
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
