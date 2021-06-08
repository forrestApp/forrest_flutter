import 'package:flutter/material.dart';

class ProfileSettings extends StatefulWidget {
  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'forRest',
          style: TextStyle(
            fontFamily: 'GloriaHalleluja',
            fontSize: 20.0,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.green[900],
      ),
      body: Padding(
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
    );
  }
}
