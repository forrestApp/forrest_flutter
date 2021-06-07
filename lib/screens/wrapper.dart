import 'package:flutter/material.dart';
import 'package:forrest_flutter/modules/firebaseUser.dart';
import 'package:forrest_flutter/screens/authenticate/authenticate.dart';
import 'package:forrest_flutter/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
