import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapLocalAlternative extends StatefulWidget {
  @override
  _MapLocalAlternativeState createState() => _MapLocalAlternativeState();
}

class _MapLocalAlternativeState extends State<MapLocalAlternative> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20.0),
              Text(
                'Hier findest du lokale Alternativen in deiner Nähe',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'GloriaHalleluja',
                  fontSize: 22.0,
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
