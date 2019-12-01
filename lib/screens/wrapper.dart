import 'package:expenses_app/models/user.dart';
import 'package:expenses_app/screens/auth/auth.dart';
import 'package:expenses_app/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //get user from stream<user>
    final user = Provider.of<User>(context);
    print(user);
    //return auth or home
    return user == null ? Auth() : Home();
  }
}
