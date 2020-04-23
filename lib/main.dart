import 'package:bizkoala_mobileapp/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

String pageTitle = 'My Quotations';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialApp(
        title: pageTitle,
        theme: ThemeData(primarySwatch: Colors.green),
        routes: routes,
      ),
      providers: <SingleChildWidget>[
        ChangeNotifierProvider.value(
          value: DrawerStateInfo(),
        )
      ],
    );
  }
}

class DrawerStateInfo with ChangeNotifier {
  int _currentDrawer = 0;
  int get getCurrentDrawer => _currentDrawer;

  void setCurrentDrawer(int drawer) {
    _currentDrawer = drawer;
    notifyListeners();
  }

  void increment() {
    notifyListeners();
  }
}
