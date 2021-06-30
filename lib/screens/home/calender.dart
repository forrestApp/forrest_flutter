import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Calender extends StatefulWidget {
  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
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
                'Behalte deine Emissionen der letzten Wochen immer im Blick:',
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
              Container(
                height: 400,
                child: SfCalendar(
                  view: CalendarView.month,
                  firstDayOfWeek: 6,
                  todayHighlightColor: Colors.green[900],
                  showNavigationArrow: true,
                  selectionDecoration: BoxDecoration(
                    color: Colors.green[900].withOpacity(0.1),
                    border: Border.all(color: Colors.green[900], width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    shape: BoxShape.rectangle,
                  ),
                  monthViewSettings: MonthViewSettings(
                      showAgenda: true,
                      agendaItemHeight: 50,
                      agendaViewHeight: 110,
                      navigationDirection: MonthNavigationDirection.horizontal,
                      monthCellStyle: MonthCellStyle(
                        backgroundColor: Colors.white,
                        todayBackgroundColor: Colors.white,
                        leadingDatesBackgroundColor: Colors.grey[50],
                        trailingDatesBackgroundColor: Colors.grey[50],
                        textStyle: TextStyle(
                          fontFamily: 'CourierPrime',
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        trailingDatesTextStyle: TextStyle(
                          fontFamily: 'CourierPrime',
                          fontSize: 14,
                          color: Colors.black.withOpacity(0.5),
                        ),
                        leadingDatesTextStyle: TextStyle(
                          fontFamily: 'CourierPrime',
                          fontSize: 14,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                      agendaStyle: AgendaStyle(
                        appointmentTextStyle: TextStyle(
                          fontFamily: 'CourierPrime',
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        dateTextStyle: TextStyle(
                            fontFamily: 'CourierPrime',
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            color: Colors.green[900]),
                        dayTextStyle: TextStyle(
                            fontFamily: 'CourierPrime',
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.green[900]),
                      )),
                  //dataSource: _getCalendarDataSource(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/*
_AppointmentDataSource _getCalendarDataSource() {
  List<Document> trackedDays = <Document>[];
  // add the value of the tracked day out of the database
  return _AppointmentDataSource(trackedDays);
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Document> source) {
    appointments = source;
  }
}*/
