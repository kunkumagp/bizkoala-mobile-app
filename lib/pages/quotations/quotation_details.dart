import 'package:flutter/material.dart';
import 'package:bizkoala_mobileapp/service/app_services.dart';
import 'package:bizkoala_mobileapp/database/helper/quote_detail_helper.dart';
import 'package:bizkoala_mobileapp/database/model/quote_detail.dart';

final appService = AppService();

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

class ItemList extends StatelessWidget {
  int quoteId;
  ItemList(this.quoteId);
  @override
  Widget build(context) {
    return FutureBuilder(
        future: QuoteDetailHelper().getAllByQuoteId(quoteId),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            List<QuoteDetail> list = snapshot.data;
            print(list);
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
              rows: list
                  .map(
                    ((element) => DataRow(
                          cells: <DataCell>[
                            DataCell(Container(
                                width: 130, child: Text("Product Name"))),
                            DataCell(Text("Qty")),
                            DataCell(
                              Container(
                                alignment: Alignment.centerRight,
                                child: Text("Line Total"),
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
        });
  }
}
