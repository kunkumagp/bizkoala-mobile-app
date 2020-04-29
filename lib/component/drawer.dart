import 'package:bizkoala_mobileapp/main.dart';
import 'package:bizkoala_mobileapp/pages/profile/my_profile.dart';
import 'package:bizkoala_mobileapp/pages/quotations/my_quotations.dart';
import 'package:bizkoala_mobileapp/pages/products_services/my_product_services.dart';
import 'package:bizkoala_mobileapp/pages/my_settings.dart';
import 'package:bizkoala_mobileapp/pages/customers/my_customers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bizkoala_mobileapp/service/app_services.dart';

final appService = AppService();

class MyDrawer extends StatelessWidget {
  MyDrawer(this.currentPage);
  final String currentPage;
  @override
  Widget build(BuildContext context) {
    var currentDrawer = Provider.of<DrawerStateInfo>(context).getCurrentDrawer;
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: currentDrawer == 0 ? Colors.grey[200] : null,
            ),
            child: ListTile(
              title: Text(
                'Quotations',
                style: currentDrawer == 0
                    ? TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)
                    : TextStyle(fontWeight: FontWeight.normal),
              ),
              leading: Icon(Icons.description),
              onTap: () {
                Navigator.of(context).pop();
                if (this.currentPage == "Quotations") return;
                Provider.of<DrawerStateInfo>(context, listen: false)
                    .setCurrentDrawer(0);

                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => MyQuotations(
                          title: 'Quotations',
                        )));
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: currentDrawer == 1 ? Colors.grey[200] : null,
            ),
            child: ListTile(
              title: Text(
                'Customers',
                style: currentDrawer == 1
                    ? TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)
                    : TextStyle(fontWeight: FontWeight.normal),
              ),
              leading: Icon(Icons.supervised_user_circle),
              onTap: () {
                Navigator.of(context).pop();
                if (this.currentPage == "Customers") return;
                Provider.of<DrawerStateInfo>(context, listen: false)
                    .setCurrentDrawer(1);

                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => MyCustomers(
                          title: 'Customers',
                        )));
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: currentDrawer == 2 ? Colors.grey[200] : null,
            ),
            child: ListTile(
              title: Text(
                "Product & Services",
                style: currentDrawer == 2
                    ? TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)
                    : TextStyle(fontWeight: FontWeight.normal),
              ),
              leading: Icon(Icons.list),
              onTap: () {
                Navigator.of(context).pop();
                if (this.currentPage == "Product & Services") return;

                Provider.of<DrawerStateInfo>(context, listen: false)
                    .setCurrentDrawer(2);

                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => ProductServices(
                          title: 'Product & Services',
                        )));
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: currentDrawer == 3 ? Colors.grey[200] : null,
            ),
            child: ListTile(
              title: Text(
                "Profile",
                style: currentDrawer == 3
                    ? TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)
                    : TextStyle(fontWeight: FontWeight.normal),
              ),
              leading: Icon(Icons.person),
              onTap: () {
                Navigator.of(context).pop();
                if (this.currentPage == "Profile") return;

                Provider.of<DrawerStateInfo>(context, listen: false)
                    .setCurrentDrawer(3);

                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => Profile(
                          title: 'Profile',
                        )));
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: currentDrawer == 4 ? Colors.grey[200] : null,
            ),
            child: ListTile(
              title: Text(
                "Settings",
                style: currentDrawer == 4
                    ? TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)
                    : TextStyle(fontWeight: FontWeight.normal),
              ),
              leading: Icon(Icons.settings),
              onTap: () {
                Navigator.of(context).pop();
                if (this.currentPage == "Settings") return;

                Provider.of<DrawerStateInfo>(context, listen: false)
                    .setCurrentDrawer(4);

                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => Settings(
                          title: 'Settings',
                        )));
              },
            ),
          ),
          // ListTile(
          //   title: Text(
          //     "Logout",
          //     style: currentDrawer == 5
          //         ? TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)
          //         : TextStyle(fontWeight: FontWeight.normal),
          //   ),
          //   leading: Icon(Icons.exit_to_app),
          //   onTap: () {
          //     appService.logout();
          //     Navigator.pushNamed(context, '/');
          //   },
          // ),
        ],
      ),
    );
  }
}
