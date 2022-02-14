import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        theme: ThemeData(
          // Define the default brightness and colors.
          primaryColor: Colors.green[900],

          // Define the default font family.
          fontFamily: 'CourierPrime',

          // Define the default TextTheme. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: const TextTheme(
              headline1: TextStyle(
                  fontSize: 27.0,
                  fontFamily: 'GloriaHalleluja',
                  color: Colors.black),
              headline2: TextStyle(
                  fontSize: 21.0,
                  fontFamily: 'GloriaHalleluja',
                  color: Colors.black),
              bodyText1: TextStyle(
                fontSize: 16.0,
                fontFamily: 'CourierPrime',
                color: Colors.black,
              )),
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: Colors.lightGreen[100]),
        ),
        home: Wrapper(),
      ),
    );
  }
}
