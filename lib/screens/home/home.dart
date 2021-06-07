import 'package:flutter/material.dart';
import 'package:forrest_flutter/services/auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int used = 0;
  final AuthService _auth = AuthService();

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
        backgroundColor: Colors.green[900],
        actions: [
          ElevatedButton.icon(
            icon: Icon(Icons.logout),
            label: Text(' '),
            onPressed: () async {
              await _auth.signOut();
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40.0),
            Text(
              'Willkommen in der App!',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'GloriaHalleluja',
                fontSize: 30.0,
              ),
            ),
            Divider(
              height: 60.0,
              color: Colors.lightGreen[500],
            ),
            SizedBox(height: 20.0),
            Text(
              'dein heutiger Stand:',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'CourierPrime',
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  color: Colors.lightGreen[100],
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '2,74',
                        style: TextStyle(
                          fontFamily: 'CourierPrime',
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'CO2-Budget',
                        style: TextStyle(
                          fontFamily: 'CourierPrime',
                          fontSize: 11.0,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  color: Colors.lightGreen[100],
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '$used',
                        style: TextStyle(
                          fontFamily: 'CourierPrime',
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'verbraucht',
                        style: TextStyle(
                          fontFamily: 'CourierPrime',
                          fontSize: 11.0,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  color: Colors.lightGreen[100],
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '24',
                        style: TextStyle(
                          fontFamily: 'CourierPrime',
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'kompensiert',
                        style: TextStyle(
                          fontFamily: 'CourierPrime',
                          fontSize: 11.0,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  color: Colors.lightGreen[100],
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '274',
                        style: TextStyle(
                          fontFamily: 'CourierPrime',
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Bilanz',
                        style: TextStyle(
                          fontFamily: 'CourierPrime',
                          fontSize: 11.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            used += 1;
          });
        },
        child: Text(
          '+',
          style: TextStyle(
            fontSize: 70.0,
            height: 0.97,
            fontFamily: 'CourierPrime',
          ),
        ),
        backgroundColor: Colors.green[900],
      ),
    );
  }
}
