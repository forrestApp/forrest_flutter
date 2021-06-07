import 'package:flutter/material.dart';
import 'package:forrest_flutter/services/auth.dart';
import 'package:forrest_flutter/shared/constants.dart';
import 'package:forrest_flutter/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';

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
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 100),
                    Text(
                      'Hier kannst du dich registrieren:',
                      style: TextStyle(
                        fontFamily: 'CourierPrime',
                        fontSize: 20.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    //emails
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Email',
                          fillColor: Colors.green[50],
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green[50])),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.green[900]))),
                      validator: (val) => val.isEmpty
                          ? 'Du hast noch keine Email angegeben'
                          : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 20),
                    //password
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Passwort',
                          fillColor: Colors.green[50],
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green[50])),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.green[900]))),
                      validator: (val) => val.length < 6
                          ? 'Dein Passwort braucht mindestens 6 Zeichen'
                          : null,
                      obscureText: true,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      child: Text('Registrieren'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green[900],
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontFamily: 'CourierPrime',
                          fontSize: 25.0,
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _auth
                              .registerWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              error = 'Bitte gib eine gültige Email an';
                              loading = false;
                            });
                          }
                        }
                      },
                    ),
                    SizedBox(height: 25),
                    Text(
                      error,
                      style: TextStyle(
                        fontFamily: 'CourierPrime',
                        fontSize: 12.0,
                      ),
                    ),
                    SizedBox(height: 60),
                    Center(
                      child: Text(
                        'Du hast schon einen Account? Dann melde dich einfach hier an:',
                        style: TextStyle(
                          fontFamily: 'CourierPrime',
                          fontSize: 20.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      child: Text('Anmelden'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green[900],
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontFamily: 'CourierPrime',
                          fontSize: 20.0,
                        ),
                      ),
                      onPressed: () {
                        widget.toggleView();
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
