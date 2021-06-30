import 'package:flutter/material.dart';

class Compensation extends StatefulWidget {
  @override
  _CompensationState createState() => _CompensationState();
}

class _CompensationState extends State<Compensation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
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
      ),
    );
  }
}
