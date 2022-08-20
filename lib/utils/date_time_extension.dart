extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month
        && day == other.day;
  }

  bool isSameMonth(DateTime other) {
    return year == other.year && month == other.month;
  }

  bool isFirstWeek() {
    return day < 8;
  }

  bool isSecondWeek() {
    return day > 7 && day < 15;
  }

  bool isThirdWeek() {
    return day > 14 && day < 22;
  }

  bool isLastWeek() {
    return day > 21;
  }

  bool isSameWeek(DateTime other) {
    final date = DateTime.utc(year, month, day);
    other = DateTime.utc(other.year, other.month, other.day);

    final diff = date.toUtc().difference(other.toUtc()).inDays;
    if(diff.abs() >= 7) {
      return false;
    }
    final min = date.isBefore(other) ? date : other;
    final max = date.isBefore(other) ? other : date;
    final result = max.weekday % 7 - min.weekday % 7 >= 0;
    return result;
  }
}