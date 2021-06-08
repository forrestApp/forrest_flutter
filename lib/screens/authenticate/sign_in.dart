import 'package:flutter/material.dart';
import 'package:forrest_flutter/screens/authenticate/forgotPassword.dart';
import 'package:forrest_flutter/services/auth.dart';
import 'package:forrest_flutter/shared/constants.dart';
import 'package:forrest_flutter/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
                    SizedBox(height: 20),
                    Text(
                      'Melde dich hier an:',
                      style: TextStyle(
                        fontFamily: 'CourierPrime',
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(height: 20),
                    //email
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
                    SizedBox(height: 20),
                    ElevatedButton(
                      child: Text('Login'),
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
                              .signInWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              error =
                                  'Der Login mit diesen Daten war nicht möglich';
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
                    TextButton(
                      child: Text(
                        'Passwort vergessen?',
                        style: TextStyle(
                          fontFamily: 'CourierPrime',
                          fontSize: 15.0,
                          color: Colors.grey,
                        ),
                      ),
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                        overlayColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed))
                              return Colors.green.withOpacity(0.12);
                            return null; // Defer to the widget's default.
                          },
                        ),
                      ),
                      onPressed: () async => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => ForgotPassword())),
                    ),
                    SizedBox(height: 40),
                    Center(
                      child: Text(
                        'Du hast noch keinen Account? Dann registriere dich hier:',
                        style: TextStyle(
                          fontFamily: 'CourierPrime',
                          fontSize: 20.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      child: Text('Registrieren'),
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
