import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

DateTime formatTimeOfDay(TimeOfDay tod) {
  final now = DateTime.now();
return DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
}

String formattedTime(DateTime time) {
 return DateFormat('hh:mm a').format(time);
}