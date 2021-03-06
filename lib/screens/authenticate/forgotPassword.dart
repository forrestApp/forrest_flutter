import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forrest_flutter/services/auth.dart';
import 'package:forrest_flutter/shared/constants.dart';
import 'package:forrest_flutter/shared/loading.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  AuthService _auth = AuthService();
  String _email;
  String error = '';
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text(
                'forRest',
                style: TextStyle(
                  fontFamily: 'GloriaHalleluja',
                  fontSize: 20.0,
                ),
              ),
              backgroundColor: Colors.green[900],
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 100),
                      Text(
                        'Gib hier deine Email ein und lass dir ein neues Passwort zuschicken:',
                        style: TextStyle(
                          fontFamily: 'CourierPrime',
                          fontSize: 20.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      //email
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Email',
                            fillColor: Colors.green[50],
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.green[50])),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.green[900]))),
                        validator: (val) => val.isEmpty
                            ? 'Du hast noch keine Email angegeben'
                            : null,
                        onChanged: (val) {
                          setState(() => _email = val);
                        },
                      ),
                      SizedBox(height: 40),
                      ElevatedButton(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("neues Passwort anfordern",
                                style: TextStyle(fontSize: 20.0),
                                textAlign: TextAlign.center),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green[900],
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontFamily: 'CourierPrime',
                              fontSize: 20.0,
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              loading = true;
                              dynamic result =
                                  await _auth.forgotPassword(_email);
                              FirebaseAuth.instance
                                  .sendPasswordResetEmail(email: _email);
                              if (result == null) {
                                loading = false;
                                Fluttertoast.showToast(
                                    msg:
                                        "Diese Email ist nicht bei uns registriert",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 2,
                                    backgroundColor: Colors.green[900],
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              } else {
                                Navigator.of(context).pop();
                                Fluttertoast.showToast(
                                    msg:
                                        "Dir wurde ein neues Passwort zugeschickt",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 2,
                                    backgroundColor: Colors.green[900],
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            }
                          })
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
