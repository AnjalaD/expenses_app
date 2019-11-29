import 'package:expenses_app/screens/auth/auth.dart';
import 'package:expenses_app/screens/home/home.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //return auth or home
    return Auth();
  }
}
