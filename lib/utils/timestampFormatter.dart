import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class TimestampFormatter {
  static String format(int timestamp) {
    DateTime date = Timestamp.fromMillisecondsSinceEpoch(timestamp).toDate();
    String dateString = DateFormat.yMMMMEEEEd().format(date);
    String timeString = DateFormat.jm().format(date);
    return '$dateString, $timeString';
  }
}