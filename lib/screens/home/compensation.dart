import 'package:flutter/material.dart';
import 'package:forrest_flutter/screens/authenticate/sign_in.dart';
import 'package:forrest_flutter/screens/home/profileSettings.dart';

class Compensation extends StatefulWidget {
  @override
  _CompensationState createState() => _CompensationState();
}

class _CompensationState extends State<Compensation> {
  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ProfileSettings()));
        break;
      case 1:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => SignIn()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'forRest',
          style: TextStyle(
            fontFamily: 'GloriaHalleluja',
            fontSize: 24.0,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.green[900],
        actions: [
          PopupMenuButton<int>(
            padding: EdgeInsets.all(2),
            onSelected: (item) => onSelected(context, item),
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                height: 30,
                textStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: 'CourierPrime',
                  fontSize: 16.0,
                ),
                value: 0,
                child: Container(
                    child: Row(
                  children: [
                    Icon(
                      Icons.settings,
                      color: Colors.green[900],
                    ),
                    SizedBox(width: 10),
                    Text('Einstellungen'),
                  ],
                )),
              ),
              PopupMenuDivider(),
              PopupMenuItem<int>(
                height: 30,
                textStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: 'CourierPrime',
                  fontSize: 16.0,
                ),
                value: 1,
                child: Container(
                    child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.green[900],
                    ),
                    SizedBox(width: 10),
                    Text('Logout'),
                  ],
                )),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.0),
            Text(
              'Hier geben wir dir die Möglichkeit deine Emissionen auszugleichen:',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'GloriaHalleluja',
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
            Divider(
              height: 60.0,
              color: Colors.lightGreen[500],
            ),
          ],
        ),
      ),
    );
  }
}
