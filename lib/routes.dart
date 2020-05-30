import 'package:bizkoala_mobileapp/pages/auth/login.dart';
import 'package:bizkoala_mobileapp/pages/auth/register.dart';
import 'package:bizkoala_mobileapp/pages/quotations/my_quotations.dart';
import 'package:bizkoala_mobileapp/pages/quotations/quotation_details.dart';
import 'package:bizkoala_mobileapp/pages/quotations/add_quotation_item.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => MyQuotations(
                  title: 'Quotations',
                ));

      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());

      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterScreen());

      case '/quotation-details':
        if (args is Object) {
          return MaterialPageRoute(
              builder: (_) => QuotationDetails(
                    data: args,
                  ));
        }

        return _errorRoute();

      case '/add-quotation-items':
        if (args is Object) {
          return MaterialPageRoute(
              builder: (_) => AddQuotationItems(
                    data: args,
                  ));
        }

        return _errorRoute();

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
