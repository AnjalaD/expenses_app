import 'package:expenses_app/services/auth.dart';
import 'package:expenses_app/shared/constants.dart';
import 'package:expenses_app/shared/loading.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;
  SignUp({this.toggleView});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //text feild state
  String email = '', password = '', error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading
        : Scaffold(
            backgroundColor: Theme.of(context).primaryColorLight,
            appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColorDark,
              elevation: 0.0,
              title: Text('Register to EXpense'),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Sign In'),
                  onPressed: widget.toggleView,
                )
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                      validator: (value) {
                        return value.isEmpty ? 'Enter an email' : null;
                      },
                      decoration: textInputDeco.copyWith(hintText: 'Email'),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      validator: (value) {
                        return value.length < 6
                            ? 'Password should have lest 6 characters'
                            : null;
                      },
                      decoration: textInputDeco.copyWith(hintText: 'Password'),
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Theme.of(context).primaryColorLight),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _auth.registerWithEmailAndPass(
                              email: email, password: password);
                          setState(() => loading = false);

                          if (result == null) {
                            setState(() {
                              error = 'Please enter valid email and password';
                            });
                          }
                        }
                      },
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    )
                  ],
                ),
              ),
            ));
  }
}
