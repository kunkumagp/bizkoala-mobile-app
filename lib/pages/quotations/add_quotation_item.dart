import 'package:flutter/material.dart';
import 'package:bizkoala_mobileapp/service/app_services.dart';

import 'package:bizkoala_mobileapp/database/helper/item_helper.dart';
import 'package:bizkoala_mobileapp/database/model/item.dart';
import 'package:bizkoala_mobileapp/database/helper/category_helper.dart';
import 'package:bizkoala_mobileapp/database/model/category.dart';
import 'package:bizkoala_mobileapp/database/helper/quote_detail_helper.dart';
import 'package:bizkoala_mobileapp/database/model/quote_detail.dart';

final appService = AppService();
List<DropdownMenuItem<String>> categoryList = [];
List itemList = [];

String selectedCategory;

class AddQuotationItems extends StatefulWidget {
  AddQuotationItems({Key key, this.data}) : super(key: key);
  final data;

  @override
  _AddQuotationItemState createState() => _AddQuotationItemState();
}

class _AddQuotationItemState extends State<AddQuotationItems> {
  TextEditingController newCategoryTitle = TextEditingController();
  TextEditingController newItemName = TextEditingController();
  TextEditingController newItemPrice = TextEditingController();
  bool decimalQntValue = false;
  bool _validateNewCategoryTitle = true;
  bool _validateNewItemName = true;
  bool _validateNewItemPrice = true;

  addNewCategory(categoryLabel, categoryName) async {
    List<Category> newCategories = [
      Category(
        parentId: 0,
        name: categoryName,
        label: categoryLabel,
      ),
    ];
    Category rnd = newCategories[0];
    await CategoryHelper().addNew(rnd);
    setState(() {});
  }

  addNewItem() async {
    // print(decimalQntValue);

    List<Item> newItem = [
      Item(
        categoryId: int.parse(selectedCategory),
        name: newItemName.text,
        price: newItemPrice.text,
      ),
    ];
    Item rnd = newItem[0];
    await ItemHelper().addNew(rnd);
    setState(() {});

    print(rnd);

    selectedCategory = null;
    newItemName.clear();
    newItemPrice.clear();
    decimalQntValue = false;
  }

  changeDecimalQntValue(newValue) {
    if (newValue == false) {
      decimalQntValue = true;
    } else if (newValue == true) {
      decimalQntValue = false;
    }
    Navigator.pop(context);
    newItemDialogBox();
  }

  newCategory() {
    var alertDialog = AlertDialog(
      content: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              TextField(
                autofocus: true,
                controller: newCategoryTitle,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'New category',
                  hintText: 'Category 1',
                  errorText: _validateNewCategoryTitle == false
                      ? 'Category Can\'t Be Empty'
                      : null,
                ),
                keyboardType: TextInputType.text,
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        SizedBox(
          width: double.maxFinite,
          child: RaisedButton(
            color: Colors.green,
            child: Text('Save'),
            onPressed: () {
              setState(() {
                newCategoryTitle.text.isEmpty
                    ? _validateNewCategoryTitle = false
                    : _validateNewCategoryTitle = true;
              });
              if (_validateNewCategoryTitle == false) {
                Navigator.pop(context);
                newCategory();
              } else {
                var newCategoryLabel;
                var newCategoryName;

                newCategoryLabel = newCategoryTitle.text;
                newCategoryName =
                    newCategoryTitle.text.replaceAll(' ', '_').toLowerCase();
                addNewCategory(newCategoryLabel, newCategoryName);

                Navigator.pop(context);
                newCategoryTitle.clear();
                setState(() {
                  newItemDialogBox();
                });
              }
            },
          ),
        ),
      ],
    );

    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return alertDialog;
          });
        });
  }

  newItemDialogBox() {
    var alertDialog = AlertDialog(
      content: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              CategoryList(),
              GestureDetector(
                  child: Container(
                    padding: EdgeInsets.only(
                        top: 4.0, left: 4.0, right: 4.0, bottom: 8.0),
                    child: Text("Create a new Category",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold)),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    newCategoryTitle.clear();
                    newCategory();
                  }),
              Divider(
                color: Colors.black,
              ),
              Container(
                padding: EdgeInsets.only(bottom: 5.0),
                child: TextField(
                  controller: newItemName,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0.5),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 1.0),
                    ),
                    hintText: 'Product/Service Name',
                    errorText: _validateNewItemName == false
                        ? 'Product/Service Name Can\'t Be Empty'
                        : null,
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 5.0),
                child: TextField(
                  controller: newItemPrice,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0.5),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 1.0),
                    ),
                    hintText: 'Price',
                    errorText: _validateNewItemPrice == false
                        ? 'Price Can\'t Be Empty'
                        : null,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              CheckboxListTile(
                title: Text("Can have decimal Qnt"),
                value: decimalQntValue,
                onChanged: (newValue) {
                  changeDecimalQntValue(decimalQntValue);
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        SizedBox(
          width: double.maxFinite,
          child: RaisedButton(
            color: Colors.green,
            child: Text('Done'),
            onPressed: () {
              setState(() {
                newItemName.text.isEmpty
                    ? _validateNewItemName = false
                    : _validateNewItemName = true;
                newItemPrice.text.isEmpty
                    ? _validateNewItemPrice = false
                    : _validateNewItemPrice = true;
              });
              if (_validateNewItemName == false ||
                  _validateNewItemPrice == false ||
                  selectedCategory == null) {
                Navigator.pop(context);
                newItemDialogBox();
              }

              if (_validateNewItemName &&
                  _validateNewItemPrice &&
                  selectedCategory != null) {
                Navigator.pop(context);
                addNewItem();
              }
            },
          ),
        ),
      ],
    );

    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return alertDialog;
          });
        });
  }

  addItemToQuotation() async {
    if (itemList.length > 0) {
      for (var i = 0; i < itemList.length; i++) {
        var item = itemList[i];
        List<QuoteDetail> newQuoteItem = [
          QuoteDetail(
            quoteId: widget.data['id'],
            itemId: item['itemId'],
            price: item['price'],
            quantity: item['qnt'],
          ),
        ];
        QuoteDetail rnd = newQuoteItem[0];
        await QuoteDetailHelper().addNew(rnd);
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final quotationId = widget.data['id'];
    final quotationTitle = widget.data['title'];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Quotation Items'),
          actions: <Widget>[
            Container(
              margin:
                  const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 15.0),
              child: RaisedButton(
                elevation: 2.0,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                    side: BorderSide(color: Colors.white)),
                onPressed: () {
                  // print(itemList);
                  addItemToQuotation();
                  AppService().onLoading(context);
                  Future.delayed(Duration(seconds: 3), () {
                    Navigator.pop(context); //pop dialog
                    Navigator.pushNamed(context, '/quotation-details',
                        arguments: {
                          'id': quotationId,
                          'title': quotationTitle,
                        });
                  });
                },
                color: Colors.white,
                textColor: Colors.green,
                child:
                    Text("done".toUpperCase(), style: TextStyle(fontSize: 14)),
              ),
            )
          ],
        ),
        body: DefaultTabController(
          length: 2,
          child: Column(
            children: <Widget>[
              Container(
                constraints: BoxConstraints.expand(height: 50),
                child: TabBar(labelColor: Colors.black, tabs: [
                  Tab(text: "Most Used"),
                  Tab(text: "Categories"),
                ]),
              ),
              Expanded(
                child: Container(
                  child: TabBarView(
                    children: [
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            MostUsedItems(quotationId),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            CategoryItems(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          elevation: 4.0,
          icon: Icon(Icons.add),
          label: Text("Add New Product or Service"),
          onPressed: () async {
            newItemDialogBox();
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: CategoryHelper().getAll(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data.length > 0) {
          var snapData = snapshot.data;
          categoryList = [];
          for (var i = 0; i < snapData.length; i++) {
            categoryList.add(DropdownMenuItem(
              child: Text(snapData[i].label),
              value: snapData[i].id.toString(),
            ));
          }
          return DropdownButton<String>(
            value: selectedCategory,
            hint: Text(
              'Select a category',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red),
            ),
            isExpanded: true,
            items: categoryList,
            onChanged: (String value) {
              setState(() {
                selectedCategory = value;
              });
            },
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Text("No Category...")],
            ),
          );
        }
      },
    );
  }
}

class CategoryItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    clearItemList();
    return FutureBuilder(
      future: CategoryHelper().getAll(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData && snapshot.data.length > 0) {
          categoryList = [];

          return Expanded(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        Icon icon = Icon(Icons.arrow_drop_down);
                        Category category = snapshot.data[index];
                        return ExpansionTile(
                          title: Container(
                            width: double.infinity,
                            child: Text(category.name),
                          ),
                          trailing: Icon(Icons.arrow_drop_down),
                          onExpansionChanged: (value) {},
                          children: <Widget>[
                            // ItemsByCategory(category.id),
                            FutureBuilder(
                              future:
                                  ItemHelper().getItemByCategoryId(category.id),
                              builder: (BuildContext context, snapshot) {
                                if (snapshot.hasData &&
                                    snapshot.data.length > 0) {
                                  return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (context, index) {
                                      Item item = snapshot.data[index];
                                      TextEditingController itemQnt =
                                          TextEditingController(text: '0');
                                      return Table(
                                        columnWidths: {
                                          0: FractionColumnWidth(.2)
                                        },
                                        children: [
                                          TableRow(
                                            children: itemRow(item, itemQnt),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  return Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text("No Product or services...")
                                      ],
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Text("No Categories...")],
            ),
          );
        }
      },
    );
  }
}

class MostUsedItems extends StatelessWidget {
  int quoteId;
  MostUsedItems(this.quoteId);

  @override
  Widget build(context) {
    clearItemList();
    return FutureBuilder(
      future: ItemHelper().getAll(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData && snapshot.data.length > 0) {
          return Expanded(
            child: ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Item item = snapshot.data[index];
                int itemId = item.id;
                // int itemQnt = item.id;
                TextEditingController itemQnt =
                    TextEditingController(text: '0');

                return Table(
                  columnWidths: {0: FractionColumnWidth(.2)},
                  children: [
                    TableRow(children: itemRow(item, itemQnt)),
                  ],
                );
              },
            ),
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Text("No Product or services...")],
            ),
          );
        }
      },
    );
  }
}

itemRow(item, itemQnt) {
  var x = [
    Container(
      padding: EdgeInsets.only(left: 25.0, top: 20.0, bottom: 20.0),
      alignment: Alignment.centerLeft,
      child: Text(
        item.name,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    Container(
      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
      alignment: Alignment.centerRight,
      child: Text(item.price),
    ),
    Container(
      alignment: Alignment.centerRight,
      child: IconButton(
          icon: Icon(Icons.remove_circle_outline),
          onPressed: () {
            int val = int.parse(itemQnt.text);
            if (val > 0) {
              val = val - 1;
              saveItemOnLocal(item, val);
            }
            itemQnt.text = val.toString();
          }),
    ),
    Container(
      padding: EdgeInsets.only(top: 5.0),
      height: 40.0,
      alignment: Alignment.centerRight,
      child: TextField(
        controller: itemQnt,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(1),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green, width: 1.0),
          ),
        ),
      ),
    ),
    Container(
      alignment: Alignment.centerLeft,
      child: IconButton(
          icon: Icon(Icons.add_circle_outline),
          onPressed: () {
            int val = int.parse(itemQnt.text);
            val = val + 1;
            if (val > 0) {
              saveItemOnLocal(item, val);
            }
            itemQnt.text = val.toString();
          }),
    ),
  ];
  return x;
}

saveItemOnLocal(item, itemQnt) {
  var productMap = {
    'itemId': item.id,
    'price': item.price,
    'qnt': itemQnt,
  };

  if (itemList.length > 0) {
    for (var i = 0; i < itemList.length; i++) {
      if (itemList[i]['itemId'] == item.id) {
        itemList.removeAt(i); // true
      }
    }
  }
  itemList.add(productMap);
}

clearItemList() {
  itemList.removeRange(0, itemList.length);
}
