import 'package:bizkoala_mobileapp/pages/auth/login.dart';
import 'package:bizkoala_mobileapp/pages/auth/register.dart';
import 'package:bizkoala_mobileapp/pages/my_quotations.dart';
import 'package:flutter/material.dart';

final routes = {
  '/login': (BuildContext context) => LoginScreen(),
  '/register': (BuildContext context) => RegisterScreen(),
  '/quotations': (BuildContext context) => MyQuotations(),
  '/': (BuildContext context) => MyQuotations(),
};
