import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forrest_flutter/services/addFoodDatabase.dart';
import 'package:forrest_flutter/shared/constants.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

final CollectionReference foodCollection =
    FirebaseFirestore.instance.collection('Ernährung');

final CollectionReference newFoodCollection =
    FirebaseFirestore.instance.collection('neues Lebensmittel');

String emissionFactorOfCategory;

String categoryOfNewFood;
String nameOfNewFood;
String originOfNewFood;
String typeOfPackaging;

int sizeOfPackaging;
int emissionsOfNewFood;
int finalEmissions;

bool organicSealState = false;
bool regionalState = false;
bool packagingIsSelected = false;

int selectedPackaging = 1;
int selectedPackagingSize = 1;

List<String> siegel;

double sliderValue = 0;

class NewFood extends StatefulWidget {
  @override
  _NewFoodState createState() => _NewFoodState();
}

class _NewFoodState extends State<NewFood> {
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
                    'Erstelle hier ein neues Lebensmittel:',
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
                        hintText: 'neues Lebensmittel',
                        fillColor: Colors.green[50],
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green[50])),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green[900]))),
                    validator: (val) => val.isEmpty
                        ? 'Du hast noch keinen Namen angegeben'
                        : null,
                    onChanged: (val) {
                      setState(() => nameOfNewFood = val);
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
                      setState(() => originOfNewFood = val);
                    },
                  ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Bio-Siegel:',
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
                              organicSealState = state;
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
                              regionalState = state;
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  Text(
                    'Tierisches Produkt?',
                    style: TextStyle(
                      fontFamily: 'CourierPrime',
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Slider(
                    value: sliderValue,
                    min: 0,
                    max: 2,
                    onChanged: (newSliderValue) {
                      setState(() {
                        sliderValue = newSliderValue;
                      });
                    },
                    activeColor: Colors.green[900],
                    inactiveColor: Colors.green[900].withOpacity(0.2),
                    divisions: 2,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        ' vegan ',
                        style: TextStyle(
                          fontFamily: 'CourierPrime',
                          fontSize: 14.0,
                          color: sliderValue == 0
                              ? Colors.grey[900]
                              : Colors.grey[500],
                        ),
                      ),
                      Text(
                        'vegetarisch',
                        style: TextStyle(
                          fontFamily: 'CourierPrime',
                          fontSize: 14.0,
                          color: sliderValue == 1
                              ? Colors.grey[900]
                              : Colors.grey[500],
                        ),
                      ),
                      Text(
                        'Fleisch',
                        style: TextStyle(
                          fontFamily: 'CourierPrime',
                          fontSize: 14.0,
                          color: sliderValue == 2
                              ? Colors.grey[900]
                              : Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
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
                                  ? Colors.lightGreen[900].withOpacity(0.5)
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
                                  packagingIsSelected = false;
                                  typeOfPackaging = null;
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
                                  ? Colors.lightGreen[900].withOpacity(0.5)
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
                                  packagingIsSelected = true;
                                  typeOfPackaging = 'Plastik';
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
                                  ? Colors.lightGreen[900].withOpacity(0.5)
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
                                  packagingIsSelected = true;
                                  typeOfPackaging = 'Papier';
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
                                  ? Colors.lightGreen[900].withOpacity(0.5)
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
                                  packagingIsSelected = true;
                                  typeOfPackaging = 'Alu';
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 40),
                      Visibility(
                        visible: packagingIsSelected,
                        child: Text(
                          'Verpackungsgröße:',
                          style: TextStyle(
                            fontFamily: 'CourierPrime',
                            fontSize: 16.0,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Visibility(
                        visible: packagingIsSelected,
                        child: Row(
                          children: [
                            IconButton(
                              icon: selectedPackagingSize == 1
                                  ? Icon(Icons.radio_button_checked_outlined)
                                  : Icon(Icons.circle_outlined),
                              onPressed: () {
                                setState(() {
                                  selectedPackagingSize = 1;
                                  sizeOfPackaging = 100;
                                });
                              },
                            ),
                            Text(
                              '10 x 10 cm',
                              style: TextStyle(
                                fontFamily: 'CourierPrime',
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(width: 20),
                            IconButton(
                              icon: selectedPackagingSize == 2
                                  ? Icon(Icons.radio_button_checked_outlined)
                                  : Icon(Icons.circle_outlined),
                              onPressed: () {
                                setState(() {
                                  selectedPackagingSize = 2;
                                  sizeOfPackaging = 400;
                                });
                              },
                            ),
                            Text(
                              '20 x 20 cm',
                              style: TextStyle(
                                fontFamily: 'CourierPrime',
                                fontSize: 16.0,
                              ),
                            )
                          ],
                        ),
                      ),
                      Visibility(
                        visible: packagingIsSelected,
                        child: Row(
                          children: [
                            IconButton(
                              icon: selectedPackagingSize == 3
                                  ? Icon(Icons.radio_button_checked_outlined)
                                  : Icon(Icons.circle_outlined),
                              onPressed: () {
                                setState(() {
                                  selectedPackagingSize = 3;
                                  sizeOfPackaging = 1600;
                                });
                              },
                            ),
                            Text(
                              '40 x 40 cm',
                              style: TextStyle(
                                fontFamily: 'CourierPrime',
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(width: 20),
                            IconButton(
                              icon: selectedPackagingSize == 4
                                  ? Icon(Icons.radio_button_checked_outlined)
                                  : Icon(Icons.circle_outlined),
                              onPressed: () {
                                setState(() {
                                  selectedPackagingSize = 4;
                                  sizeOfPackaging = 3600;
                                });
                              },
                            ),
                            Text(
                              '60 x 60 cm',
                              style: TextStyle(
                                fontFamily: 'CourierPrime',
                                fontSize: 16.0,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 40),
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
                          newFoodCollection
                              .get()
                              .then((QuerySnapshot querySnapshot) {
                            querySnapshot.docs
                                .forEach((DocumentSnapshot documentSnapshot) {
                              print(documentSnapshot
                                  .data()); //hier müssen die Ausgelesenen Emissionen Variablen zugewiesen werden, um die Emissionen zu berechnen
                            });
                          });
                          AddFoodDatabaseService(
                                  foodCategory: categoryOfNewFood)
                              .addNewFood(
                                  nameOfNewFood,
                                  emissionsOfNewFood,
                                  siegel,
                                  originOfNewFood,
                                  sliderValue,
                                  selectedPackaging);
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(height: 100),
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
