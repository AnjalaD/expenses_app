import 'package:expenses_app/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColorLight,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColorDark,
          elevation: 0.0,
          title: Text('Sign In to EXpense'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: RaisedButton(
            child: Text('Sign in anon'),
            onPressed: () async {
              dynamic user = await _auth.signInAnon();
              if (user == null) {
                print('error in sign in');
              } else {
                print('signed in');
                print(user);
              }
            },
          ),
        ));
  }
}
