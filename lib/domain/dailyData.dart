import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';

class DailyData {
  final DateTime date;
  final String title;
  final MaterialColor color;

  DailyData({this.date, this.title, this.color}) : assert(date != null);

  @override
  bool operator ==(other) {
    return this.date == other.date &&
        this.title == other.title &&
        this.color == other.color;
  }
}