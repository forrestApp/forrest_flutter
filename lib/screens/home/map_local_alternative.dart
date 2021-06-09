import 'package:flutter/material.dart';
import 'package:forrest_flutter/screens/authenticate/sign_in.dart';
import 'package:forrest_flutter/screens/home/profileSettings.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapLocalAlternative extends StatefulWidget {
  @override
  _MapLocalAlternativeState createState() => _MapLocalAlternativeState();
}

class _MapLocalAlternativeState extends State<MapLocalAlternative> {
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

  /*GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }*/

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
            /*GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
