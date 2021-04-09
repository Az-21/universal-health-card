import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// ⸻⸻⸻⸻⸻⸻⸻⸻
// * Function: Print Day | Date
// ⸻⸻⸻⸻⸻⸻⸻⸻
String formattedDate() {
  DateTime now = DateTime.now();
  // EEEE gives the day of the week
  // dd gives the day
  // MMMM dives the month
  // yyyy gives the year

  return DateFormat('EEEE | MMMM dd, yyyy').format(now);
}

// ⸻⸻⸻⸻⸻⸻⸻⸻
// * Function: Snackbar
// ⸻⸻⸻⸻⸻⸻⸻⸻
void infoSnackbar(String title, String subtitle, bool success) {
  Get.snackbar(
    '$title',
    '$subtitle',
    icon: success
        ? Icon(Icons.done_all, color: Colors.white)
        : Icon(Icons.error_outline, color: Colors.white),
    shouldIconPulse: true,
    colorText: Colors.white,
    barBlur: 2,
    backgroundColor: success ? Colors.green : Colors.redAccent,
    isDismissible: true,
    duration: Duration(seconds: 5),
  );
}
