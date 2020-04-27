import 'package:bizkoala_mobileapp/pages/auth/login.dart';
import 'package:bizkoala_mobileapp/pages/auth/register.dart';
import 'package:bizkoala_mobileapp/pages/quotations/my_quotations.dart';
import 'package:bizkoala_mobileapp/pages/quotations/update_quotation.dart';
import 'package:flutter/material.dart';

final routes = {
  '/': (BuildContext context) => MyQuotations(
        title: 'Quotations',
      ),
  '/login': (BuildContext context) => LoginScreen(),
  '/register': (BuildContext context) => RegisterScreen(),

  // Quotatuins
  '/quotations': (BuildContext context) => MyQuotations(
        title: 'Quotations',
      ),
  '/update-quotation': (BuildContext context) => UpdateQuotations(
        title: 'Create/Edit Quotation',
      ),
};
