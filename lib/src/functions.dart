import 'package:intl/intl.dart';

// ⸻⸻⸻⸻⸻⸻⸻⸻
// * Function: Print Day | Date
// ⸻⸻⸻⸻⸻⸻⸻⸻
String formattedDate() {
  var now = DateTime.now();
  // EEEE gives the day of the week
  // dd gives the day
  // MMMM dives the month
  // yyyy gives the year

  return DateFormat('EEEE | MMMM dd, yyyy').format(now);
}
