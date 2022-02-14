import 'package:flutter/material.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime selectedDate = DateTime.now(); // TO tracking date

  int currentDateSelectedIndex = 0; //For Horizontal Date
  ScrollController scrollController =
      ScrollController(); //To Track Scroll of ListView

  List<String> listOfMonths = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  List<String> listOfDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Text('My Calendar'),
      ),
      body: Column(
        children: [
          //To Show Current Date
          Container(
              height: 30,
              margin: EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              child: Text(
                selectedDate.day.toString() +
                    '-' +
                    listOfMonths[selectedDate.month - 1] +
                    ', ' +
                    selectedDate.year.toString(),
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.indigo[700]),
              )),
          SizedBox(height: 10),
          //To show Calendar Widget
          Container(
              height: 80,
              child: Container(
                  child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(width: 10);
                },
                itemCount: 365,
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        currentDateSelectedIndex = index;
                        selectedDate =
                            DateTime.now().add(Duration(days: index));
                      });
                    },
                    child: Container(
                      height: 80,
                      width: 60,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[400],
                                offset: Offset(3, 3),
                                blurRadius: 5)
                          ],
                          color: currentDateSelectedIndex == index
                              ? Colors.black
                              : Colors.white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            listOfMonths[DateTime.now()
                                        .add(Duration(days: index))
                                        .month -
                                    1]
                                .toString(),
                            style: TextStyle(
                                fontSize: 16,
                                color: currentDateSelectedIndex == index
                                    ? Colors.white
                                    : Colors.grey),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            DateTime.now()
                                .add(Duration(days: index))
                                .day
                                .toString(),
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: currentDateSelectedIndex == index
                                    ? Colors.white
                                    : Colors.grey),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            listOfDays[DateTime.now()
                                        .add(Duration(days: index))
                                        .weekday -
                                    1]
                                .toString(),
                            style: TextStyle(
                                fontSize: 16,
                                color: currentDateSelectedIndex == index
                                    ? Colors.white
                                    : Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ))),
        ],
      ),
    ));
  }
}

class CalenderCircle extends StatelessWidget {
  const CalenderCircle({
    Key key,
    @required this.weekday,
    @required this.calenderShortcutIcon,
    @required this.calenderShortcutColor,
  }) : super(key: key);

  final String weekday;
  final Color calenderShortcutColor;
  final calenderShortcutIcon;

  checkCalenderDayIsMonday() {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: calenderShortcutColor,
                  border: Border.all(color: calenderShortcutColor, width: 2)),
            ),
            Positioned(
              top: 3,
              right: 4,
              child: Icon(
                calenderShortcutIcon,
                size: 28,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          weekday,
          style: TextStyle(
              fontSize: 14,
              fontFamily: 'CourierPrime',
              color: Colors.grey[700]),
        )
      ],
    );
  }
}

class CalenderCircleToday extends StatelessWidget {
  const CalenderCircleToday({
    Key key,
    @required this.weekday,
    @required this.calenderShortcutIcon,
    @required this.calenderShortcutColor,
  }) : super(key: key);

  final String weekday;
  final Color calenderShortcutColor;
  final calenderShortcutIcon;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: calenderShortcutColor,
                  border: Border.all(color: calenderShortcutColor, width: 2)),
            ),
            Positioned(
              top: 3,
              right: 4,
              child: Icon(
                calenderShortcutIcon,
                size: 28,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          weekday,
          style: TextStyle(
              fontSize: 14,
              fontFamily: 'CourierPrime',
              color: Colors.grey[700]),
        )
      ],
    );
  }
}

class CalenderCircleSoon extends StatelessWidget {
  const CalenderCircleSoon({
    Key key,
    @required this.weekday,
    @required this.calenderShortcutColor,
  }) : super(key: key);

  final String weekday;
  final Color calenderShortcutColor;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: calenderShortcutColor, width: 2)),
            ),
            /*Positioned(
                top: 3,
                right: 4,
                child: Container(
                  height: 34,
                  width: 34,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100)),
                )),*/
          ],
        ),
        SizedBox(height: 4),
        Text(
          weekday,
          style: TextStyle(
              fontSize: 14,
              fontFamily: 'CourierPrime',
              color: Colors.grey[700]),
        )
      ],
    );
  }
}
