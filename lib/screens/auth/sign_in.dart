import 'package:expenses_app/services/auth.dart';
import 'package:expenses_app/shared/constants.dart';
import 'package:expenses_app/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //text feild state
  String email = '', password = '', error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Theme.of(context).primaryColorLight,
            appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColorDark,
              elevation: 0.0,
              title: Text('Sign In to EXpense'),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Register'),
                  onPressed: widget.toggleView,
                )
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              // child: RaisedButton(
              //   child: Text('Sign in anon'),
              //   onPressed: () async {
              //     dynamic user = await _auth.signInAnon();
              //     if (user == null) {
              //       print('error in sign in');
              //     } else {
              //       print('signed in');
              //       print(user.uid);
              //     }
              //   },
              // ),
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
                        return value.isEmpty ? 'Enter the email' : null;
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
                        return value.isEmpty ? 'Enter the password' : null;
                      },
                      decoration: textInputDeco.copyWith(hintText: 'Password'),
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                            color: Theme.of(context).primaryColorLight),
                      ),
                      onPressed: () async {
                        setState(() => loading = true);
                        if (_formKey.currentState.validate()) {
                          dynamic result = _auth.signInWithEmailAndPass(
                              email: email, password: password);

                          if (result == null) {
                            setState(() {
                              error = 'Email and password dose not match';
                            });
                          }
                        }
                        setState(() => loading = false);
                      },
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                    MaterialButton(
                      splashColor: Theme.of(context).primaryColor,
                      color: Colors.white,
                      onPressed: () async {
                        setState(() => loading = true);
                        _auth.signInWithGoogleAccount();
                        setState(() => loading = true);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      highlightElevation: 0,
                      // borderSide:
                      // BorderSide(color: Theme.of(context).primaryColor),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image(
                                image: AssetImage('assets/google.png'),
                                height: 30.0),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'Sign in with Google',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
