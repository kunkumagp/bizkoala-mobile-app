import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:bizkoala_mobileapp/service/app_services.dart';

ProgressDialog pr;
final appService = AppService();

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginPageLayout(),
    );
  }
}

class LoginPageLayout extends StatelessWidget {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);
    pr.style(
        message: 'Please Waiting...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));

    return Center(
      child: Container(
        decoration: BoxDecoration(color: Colors.green),
        padding: EdgeInsets.all(15),
        alignment: AlignmentDirectional(0.0, 0.0),
        child: Container(
          padding: EdgeInsets.all(15),
          color: Colors.white,
          constraints: BoxConstraints(maxHeight: 300.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Center(
                  child: Text(
                    'BizKoala',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: Text(
                    'User Login',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              TextField(
                controller: usernameController,
                decoration:
                    InputDecoration(labelText: 'Username', hintText: 'sam'),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: passwordController,
                decoration:
                    InputDecoration(labelText: 'Password', hintText: '***'),
                keyboardType: TextInputType.visiblePassword,
              ),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                    color: Colors.yellow,
                    child: Text('Login'),
                    onPressed: () {
                      pr.show();
                      Future.delayed(Duration(seconds: 3)).then((value) {
                        pr.hide().whenComplete(() {
                          print('login submit');
                          appService.login();
                          Navigator.pushNamed(context, '/quotations');
                        });
                      });
                    }),
              ),
              Padding(padding: EdgeInsets.only(top: 10.0, bottom: 10.0)),
              Container(
                child: Column(
                  children: <Widget>[
                    Text("Don't have an account yet ?."),
                    Padding(padding: EdgeInsets.only(top: 5.0, bottom: 5.0)),
                    GestureDetector(
                        child: Text("Register Now",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                color: Colors.blue)),
                        onTap: () {
                          Navigator.pushNamed(context, '/register');
                        }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
