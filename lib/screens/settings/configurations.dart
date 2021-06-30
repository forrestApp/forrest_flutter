import 'package:flutter/material.dart';
import 'package:forrest_flutter/screens/settings/profile.dart';
import 'package:forrest_flutter/services/auth.dart';

class Configuration extends StatefulWidget {
  @override
  _ConfigurationState createState() => _ConfigurationState();
}

class _ConfigurationState extends State<Configuration> {
  final AuthService _auth = AuthService();

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Profile()));
        break;
      case 1:
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
                height: 40,
                textStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: 'CourierPrime',
                  fontSize: 16.0,
                ),
                value: 0,
                child: Container(
                    child: Row(
                  children: [
                    SizedBox(width: 5),
                    Icon(
                      Icons.person,
                      size: 28,
                      color: Colors.green[900],
                    ),
                    SizedBox(width: 10),
                    Text('Profil'),
                  ],
                )),
              ),
              PopupMenuItem<int>(
                height: 40,
                textStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: 'CourierPrime',
                  fontSize: 16.0,
                ),
                value: 1,
                child: Container(
                    child: Row(
                  children: [
                    SizedBox(width: 5),
                    Icon(
                      Icons.settings,
                      size: 28,
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
                value: 2,
                child: TextButton(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.green[900],
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Logout',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'CourierPrime',
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () async {
                    await _auth.signOut();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Einstellungen',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'GloriaHalleluja',
                  fontSize: 25.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
