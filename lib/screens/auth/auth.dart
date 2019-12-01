import 'package:expenses_app/screens/auth/sign_in.dart';
import 'package:expenses_app/screens/auth/sign_up.dart';
import 'package:flutter/material.dart';

class Auth extends StatefulWidget {
  Auth({Key key}) : super(key: key);

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool showSignIn = true;
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showSignIn
        ? SignIn(
            toggleView: toggleView,
          )
        : SignUp(
            toggleView: toggleView,
          );
  }
}
