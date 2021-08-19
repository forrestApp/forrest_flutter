import 'package:flutter/material.dart';
import 'package:forrest_flutter/shared/constants.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class NewConsumtion extends StatefulWidget {
  @override
  _NewConsumtionState createState() => _NewConsumtionState();
}

String categoryOfNewConsumtion;
String nameOfNewConsumtion;
int emissionsOfNewConsumtion;
String originOfNewConsumtion;

int selectedPackaging = 1;

class _NewConsumtionState extends State<NewConsumtion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Column(
                children: [
                  Text(
                    'Erstelle hier einen neuen Konsumartikel:',
                    style: TextStyle(
                      fontFamily: 'GloriaHalleluja',
                      fontSize: 22.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Name:',
                    style: TextStyle(
                      fontFamily: 'CourierPrime',
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                        hintText: 'neuer Konsumartikel',
                        fillColor: Colors.green[50],
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green[50])),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green[900]))),
                    validator: (val) => val.isEmpty
                        ? 'Du hast noch keinen Namen angegeben'
                        : null,
                    onChanged: (val) {
                      setState(() => nameOfNewConsumtion = val);
                    },
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Herkunft:',
                    style: TextStyle(
                      fontFamily: 'CourierPrime',
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Herkunft',
                        fillColor: Colors.green[50],
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green[50])),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green[900]))),
                    validator: (val) => val.isEmpty
                        ? 'Du hast noch keinen Herkunftsort eingeben'
                        : null,
                    onChanged: (val) {
                      setState(() => originOfNewConsumtion = val);
                    },
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'GOT-Siegel:',
                            style: TextStyle(
                              fontFamily: 'CourierPrime',
                              fontSize: 16.0,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: 5),
                          LiteRollingSwitch(
                            value: false,
                            textOn: '',
                            textOff: '',
                            colorOn: Colors.lightGreen[400].withOpacity(0.8),
                            colorOff: Colors.orange[200],
                            iconOn: Icons.check,
                            iconOff: Icons.close,
                            onChanged: (bool state) {
                              print('turned ${(state) ? 'on' : 'off'}');
                            },
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Regional:',
                            style: TextStyle(
                              fontFamily: 'CourierPrime',
                              fontSize: 16.0,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: 5),
                          LiteRollingSwitch(
                            value: false,
                            textOn: '',
                            textOff: '',
                            colorOn: Colors.lightGreen[400].withOpacity(0.8),
                            colorOff: Colors.orange[200],
                            iconOn: Icons.check,
                            iconOff: Icons.close,
                            onChanged: (bool state) {
                              print('turned ${(state) ? 'on' : 'off'}');
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Verpackungsart:',
                        style: TextStyle(
                          fontFamily: 'CourierPrime',
                          fontSize: 16.0,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 7),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 40,
                            width: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: selectedPackaging == 1
                                  ? Colors.lightGreen[900].withOpacity(0.6)
                                  : Colors.green[900].withOpacity(0.8),
                            ),
                            child: TextButton(
                              child: Text(
                                'keine',
                                style: TextStyle(
                                  fontFamily: 'CourierPrime',
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  selectedPackaging = 1;
                                });
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            height: 40,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: selectedPackaging == 2
                                  ? Colors.lightGreen[900].withOpacity(0.6)
                                  : Colors.green[900].withOpacity(0.8),
                            ),
                            child: TextButton(
                              child: Text(
                                'Plastik',
                                style: TextStyle(
                                  fontFamily: 'CourierPrime',
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  selectedPackaging = 2;
                                });
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            height: 40,
                            width: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: selectedPackaging == 3
                                  ? Colors.lightGreen[900].withOpacity(0.6)
                                  : Colors.green[900].withOpacity(0.8),
                            ),
                            child: TextButton(
                              child: Text(
                                'Papier',
                                style: TextStyle(
                                  fontFamily: 'CourierPrime',
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  selectedPackaging = 3;
                                });
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            height: 40,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: selectedPackaging == 4
                                  ? Colors.lightGreen[900].withOpacity(0.6)
                                  : Colors.green[900].withOpacity(0.8),
                            ),
                            child: TextButton(
                              child: Text(
                                'Alu',
                                style: TextStyle(
                                  fontFamily: 'CourierPrime',
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  selectedPackaging = 4;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 60),
                      ElevatedButton(
                        child: Text('Fertig'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green[900],
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontFamily: 'CourierPrime',
                            fontSize: 25.0,
                          ),
                        ),
                        onPressed: () {
                          /*AddFoodDatabaseService(
                                  foodCategory: categoryOfNewFood)
                              .addNewFood(nameOfNewFood, emissionsOfNewFood,
                                  originOfNewFood);
                          Navigator.pop(context);*/
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
