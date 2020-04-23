import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RegisterScreenLayout(),
    );
  }
}

class RegisterScreenLayout extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(color: Colors.green),
        padding: EdgeInsets.all(15),
        alignment: AlignmentDirectional(0.0, 0.0),
        child: Container(
          padding: EdgeInsets.all(15),
          color: Colors.white,
          constraints: BoxConstraints(maxHeight: 400.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RichText(
                text: TextSpan(style: TextStyle(fontSize: 24), children: [
                  TextSpan(
                      text: 'BizKoala ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black)),
                ]),
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: 'App Registration',
                      style: TextStyle(fontSize: 18, color: Colors.black)),
                ]),
              ),
              TextField(
                controller: emailController,
                decoration:
                    InputDecoration(labelText: 'Email', hintText: 'sam'),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: passwordController,
                decoration:
                    InputDecoration(labelText: 'Password', hintText: '***'),
                keyboardType: TextInputType.visiblePassword,
              ),
              TextField(
                controller: cPasswordController,
                decoration: InputDecoration(
                    labelText: 'Confirm Password', hintText: '***'),
                keyboardType: TextInputType.visiblePassword,
              ),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                    color: Colors.yellow,
                    child: Text('Register'),
                    onPressed: () {
                      print('register submit');
                      // Navigator.pushNamed(context, '/quotations');
                    }),
              ),
              Padding(padding: EdgeInsets.only(top: 10.0, bottom: 10.0)),
              Container(
                child: Column(
                  children: <Widget>[
                    Text("Already have an account ?."),
                    Padding(padding: EdgeInsets.only(top: 5.0, bottom: 5.0)),
                    GestureDetector(
                        child: Text("Login Here",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                color: Colors.blue)),
                        onTap: () {
                          Navigator.pushNamed(context, '/login');
                        }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
    ;
  }
}
