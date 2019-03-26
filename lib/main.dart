import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter/services.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;

import 'domain/dailyData.dart' show DailyData;

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,// navigation bar color
    statusBarColor: Colors.white, // stat
    statusBarIconBrightness: Brightness.dark // us bar color
  ));
  runApp(DiabetesDiaryApp());
}

class DiabetesDiaryApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diabetes Diary',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primaryColor: Colors.white),
      //    home: MyHomePage(title: 'Diabetes Journal'),
      home: DefaultTabController(
        length: 3,
        child: MyHomePage(title: 'Diabetes Journal'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = '';
  bool weekFormat = false;

//  List<DateTime> _markedDate = [DateTime(2018, 9, 20), DateTime(2018, 10, 11)];
  static Widget _eventIcon = new Container(
    color: Colors.red,
  );

  static Widget _dayWidget = new Container();

  EventList<DailyData> _markedDateMap = new EventList<DailyData>();

  CalendarCarousel _calendarCarousel;
  FloatingActionButton _floatingActionButton;

  @override
  void initState() {
    /// Add more events to _markedDateMap EventList
    _markedDateMap.add(
        new DateTime(2019, 02, 10),
        new DailyData(
          date: new DateTime(2019, 02, 10),
          title: "Title",
          color: Colors.green,
        ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// Example Calendar Carousel without header and custom prev & next button
    _calendarCarousel = CalendarCarousel<DailyData>(
      todayBorderColor: Colors.lightGreen,
      onDayPressed: (DateTime date, List<DailyData> events) {
        this.weekFormat = !this.weekFormat;
        this.setState(() => _currentDate2 = date);
        events.forEach((event) => print(event.title));
      },
      inactiveWeekendTextStyle: TextStyle(
        color: Colors.blue[100],
      ),
      weekendTextStyle: TextStyle(
        color: Colors.blue[300],
      ),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: weekFormat,
      markedDatesMap: _markedDateMap,
      height: 600.0,
      selectedDateTime: _currentDate2,
      customGridViewPhysics: AlwaysScrollableScrollPhysics(),
      markedDateShowIcon: true,
      markedDateIconMaxShown: 1,
      markedDateMoreShowTotal: null,
      // null for not showing hidden events indicator
      showHeader: true,
      markedDateIconBuilder: (dailyData) {
        return new Container(
          decoration: new BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(1000)),
              border: Border.all(color: dailyData.color, width: 2.0)),
        );
      },
      locale: "en_gb",
      todayTextStyle: TextStyle(
        color: Colors.black,
      ),
      todayButtonColor: Colors.transparent,
      selectedDayButtonColor: Colors.grey,
      minSelectedDate: _currentDate.subtract(Duration(days: 60)),
      maxSelectedDate: _currentDate,
//      inactiveDateColor: Colors.black12,
      onCalendarChanged: (DateTime date) {
        this.setState(() => _currentMonth = DateFormat.yMMM().format(date));
      },
    );

    _floatingActionButton = FloatingActionButton(
      tooltip: 'Actions',
      child: Icon(Icons.create),
    );

    return new Scaffold(
      body: TabBarView(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                //custom icon
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 1.0),
                  child: _calendarCarousel,
                  decoration:
                      new BoxDecoration(color: Colors.white, boxShadow: [
                    new BoxShadow(
                      color: Colors.black,
                      blurRadius: 10.0,
                    ),
                  ]),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: new Divider(
                    height: 5.0,
                  ),
                ), //
              ],
            ),
          ),
          new Container(
            color: Colors.orange,
          ),
          new Container(
            color: Colors.lightGreen,
          ),
        ],
      ),
      floatingActionButton: Container(
        child: new FloatingActionButton(
          tooltip: 'Actions',
          backgroundColor: Colors.white,
          child: Icon(Icons.add, color: Colors.blue,),
        ),
        decoration: new BoxDecoration(color: Colors.transparent, shape: BoxShape.circle, boxShadow: [
          new BoxShadow(
            offset: Offset(2.5, 5.0),
            color: Colors.black12,
            blurRadius: 0.5,
          ),
        ]),
      ),
      bottomNavigationBar: Container(
        child: new TabBar(
          tabs: [
            Tab(icon: Icon(Icons.calendar_today), text: "Diary",),
            Tab(icon: Icon(Icons.show_chart), text: "Chart"),
            Tab(icon: Icon(Icons.account_circle), text: "Account"),
          ],
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: EdgeInsets.all(5.0),
          indicatorColor: Colors.blue,
        ),
        decoration: new BoxDecoration(color: Colors.white, boxShadow: [
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 5.0,
          ),
        ]),
      ),
    );
  }
}
