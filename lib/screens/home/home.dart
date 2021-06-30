import 'package:flutter/material.dart';
import 'package:forrest_flutter/screens/home/expansionLists/expansionListActivities.dart';
import 'package:forrest_flutter/screens/home/expansionLists/expansionListConsumtion.dart';
import 'package:forrest_flutter/screens/home/expansionLists/expansionListFood.dart';
import 'package:forrest_flutter/screens/home/expansionLists/expansionListTransport.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int used = 0;
  GlobalKey actionKey;

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
              Card(
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
              SizedBox(height: 20.0),
              Text(
                'Willkommen in der App!',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'GloriaHalleluja',
                  fontSize: 30.0,
                ),
              ),
              Divider(
                height: 50.0,
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
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CalculationContainer(
                    number: '274',
                    describtion: 'CO2-Budget',
                  ),
                  CalculationArithmeticSymbol(symbol: '-'),
                  CalculationContainer(
                    number: '$used',
                    describtion: 'verbraucht',
                  ),
                  CalculationArithmeticSymbol(symbol: '+'),
                  CalculationContainer(
                    number: '0',
                    describtion: 'gepflanzt',
                  ),
                  CalculationArithmeticSymbol(symbol: '='),
                  CalculationContainer(
                    number: '274',
                    describtion: 'Bilanz',
                  ),
                ],
              ),
              Divider(
                height: 60.0,
                color: Colors.lightGreen[500],
              ),
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
