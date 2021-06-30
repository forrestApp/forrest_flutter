import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:forrest_flutter/screens/wrapper.dart';
import 'package:forrest_flutter/services/auth.dart';
import 'package:provider/provider.dart';

import 'modules/firebaseUser.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ForRest());
}

class ForRest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.lightGreen[100]);
    FlutterStatusbarcolor.setNavigationBarColor(Colors.lightGreen[100]);
    return StreamProvider<FirebaseUser>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        /*localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en'),
          const Locale('zh'),
          const Locale('he'),
          const Locale('ru'),
          const Locale('fr', 'BE'),
          const Locale('fr', 'CA'),
          const Locale('ja'),
          const Locale('de'),
          const Locale('hi'),
          const Locale('ar'),
        ],
        locale: const Locale('zh'),
        debugShowCheckedModeBanner: false,*/
        home: Wrapper(),
      ),
    );
  }
}
