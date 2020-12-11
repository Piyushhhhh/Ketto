import 'package:intl/intl.dart';

class DateDelegate {
  static String getDateForEventItem(DateTime dateTime) {
    DateFormat formatter = DateFormat("E, MMM d, yyyy |").add_jm();
    return [formatter.format(dateTime), 'IST'].join(" ");
  }
}
