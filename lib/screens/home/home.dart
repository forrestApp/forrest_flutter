import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forrest_flutter/screens/home/expansionLists/expansionListActivities.dart';
import 'package:forrest_flutter/screens/home/expansionLists/expansionListConsumtion.dart';
import 'package:forrest_flutter/screens/home/expansionLists/expansionListFood.dart';
import 'package:forrest_flutter/screens/home/expansionLists/expansionListTransport.dart';
import 'package:intl/intl.dart';

double calculationBudget = 24.6;
double calculationUsed, calculationCompensated, calculationBilanz;
final CollectionReference userFoodCollection =
    FirebaseFirestore.instance.collection('Nutzerdaten');

String todaysDate = DateFormat.yMMMd().format(DateTime.now());

FirebaseAuth auth = FirebaseAuth.instance;
User user = auth.currentUser;

bool isEmissionsExceeded;
Color calenderShortcutColor = Colors.green;
var calenderShortcutIcon;

List currentTransportEmissions;
String readingTodaysList;

Future readingData() async {
  QuerySnapshot snap = await FirebaseFirestore.instance
      .collection('Nutzerdaten')
      .doc(user.uid)
      .collection('NutzerTracking')
      .doc('Mobilität')
      .collection(todaysDate)
      .get();

  snap.docs.forEach((document) {
    print(document.id);
    readingTodaysList = document.id;
  });
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int used = 0;
  GlobalKey actionKey;

  @override
  void initState() {
    calculateTodayCo2Bilanz();
    readingData();
    super.initState();
  }

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
              SizedBox(height: 10),
              /*Card(
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Container(
                  height: 100,
                  child: SfCalendar(
                    view: CalendarView.month,
                    firstDayOfWeek: 6,
                    todayHighlightColor: Colors.green[900],
                    selectionDecoration: BoxDecoration(
                      color: Colors.white.withOpacity(0),
                      border: Border.all(
                          color: Colors.white.withOpacity(0), width: 0),
                    ),
                    monthViewSettings: MonthViewSettings(
                      numberOfWeeksInView: 1,
                      monthCellStyle: MonthCellStyle(
                        backgroundColor: Colors.white,
                        todayBackgroundColor: Colors.white,
                        textStyle: TextStyle(
                          fontFamily: 'CourierPrime',
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),*/

              SizedBox(height: 10),
              Text(
                'Willkommen!',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'GloriaHalleluja',
                  fontSize: 35.0,
                ),
              ),
              Divider(
                height: 30.0,
                color: Colors.lightGreen[500],
              ),
              Text(
                'dein heutiger Stand:',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'CourierPrime',
                  fontSize: 20.0,
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CalculationContainer(
                    number: calculationBudget.toString(),
                    describtion: 'CO2-Budget',
                  ),
                  CalculationArithmeticSymbol(symbol: '-'),
                  CalculationContainer(
                    number: calculationUsed == null
                        ? '0'
                        : calculationUsed.toString(),
                    describtion: 'verbraucht',
                  ),
                  CalculationArithmeticSymbol(symbol: '+'),
                  CalculationContainer(
                    number: calculationCompensated == null
                        ? '0'
                        : calculationCompensated.toString(),
                    describtion: 'gepflanzt',
                  ),
                  CalculationArithmeticSymbol(symbol: '='),
                  CalculationContainer(
                    number: calculationBilanz.toString(),
                    describtion: 'Bilanz',
                  ),
                ],
              ),
              Divider(
                height: 60.0,
                color: Colors.lightGreen[500],
              ),
              //ReadData(), hier soll testweise die Daten aus der Datenbank ausgelesen werden
              //Text(readingTodaysList),
              ExpansionListFood(),
              SizedBox(height: 15),
              ExpansionListConsumtion(),
              SizedBox(height: 15),
              ExpansionListTransport(),
              SizedBox(height: 15),
              ExpansionListActivities(),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

calculateTodayCo2Bilanz() {
  if (calculationUsed == null && calculationCompensated == null) {
    calculationBilanz = calculationBudget;
  } else if (calculationUsed == null) {
    calculationBilanz = calculationBudget + calculationCompensated;
  } else if (calculationCompensated == null) {
    calculationBilanz = calculationBudget - calculationUsed;
  } else {
    calculationBilanz =
        calculationBudget - calculationUsed + calculationCompensated;
  }
  if (calculationBilanz < 0) {
    isEmissionsExceeded = true;
    calenderShortcutColor = Colors.red[800];
    calenderShortcutIcon = Icons.close_outlined;
  } else {
    isEmissionsExceeded = false;
    calenderShortcutColor = Colors.green[900];
    calenderShortcutIcon = Icons.check;
  }
}

class CalculationArithmeticSymbol extends StatelessWidget {
  const CalculationArithmeticSymbol({
    Key key,
    @required this.symbol,
  }) : super(key: key);

  final String symbol;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 25,
      child: Text(
        symbol,
        style: TextStyle(
          fontFamily: 'CourierPrime',
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class CalculationContainer extends StatelessWidget {
  const CalculationContainer({
    Key key,
    @required this.describtion,
    @required this.number,
  }) : super(key: key);

  final String describtion, number;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.lightGreen[100],
      ),
      width: 65,
      height: 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            number,
            style: TextStyle(
              fontFamily: 'CourierPrime',
              fontSize: 20.0,
            ),
          ),
          SizedBox(height: 4),
          Text(
            describtion,
            style: TextStyle(
              fontFamily: 'CourierPrime',
              fontSize: 10.0,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
