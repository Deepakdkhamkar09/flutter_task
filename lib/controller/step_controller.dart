import 'package:flutter/material.dart';
import 'package:flutter_task/profile_screen.dart';
import 'package:get/get.dart';

class StepsController extends GetxController {
  int currentStep = 1;

  DateTime? fromDate;
  DateTime? toDate;
  int occurrenceCount = 0;

  List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  String? selectedDay = 'Monday';
  void stepDecrement() {
    debugPrint('currentStep: $currentStep');
    if (currentStep == 1) {
      Get.offAll(const ProfileScreen());
    } else {
      currentStep--;
      debugPrint('currentStep: $currentStep');
    }
    update();
  }

  void stepIncrement() {
    if (currentStep < 4) {
      debugPrint('currentStep: $currentStep');

      if (currentStep == 2) {
        if (fromDate != null && toDate != null) {
          currentStep++;
        } else {
          Get.snackbar("Error", "Please select Date fields",
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      } else {
        currentStep++;
      }

      if (currentStep == 4) {
        Get.offAll(const ProfileScreen());
      }
      update();
    }

    update();
  }

  void selectDay(String day) {
    selectedDay = day;
    update();
  }

  void fromDateSelected(DateTime value) {
    fromDate = value;
    update();
  }

  void toDateSelected(DateTime value) {
    toDate = value;
    update();
  }

  int calculateOccurrences(
      String selectedDay, DateTime fromDate, DateTime toDate) {
    DateTime date = fromDate;
    while (date.isBefore(toDate) || date.isAtSameMomentAs(toDate)) {
      if (date.weekday == days.indexOf(selectedDay) + 1) {
        occurrenceCount++;
      }
      date = date.add(Duration(days: 1));
    }
    print("total Days--$occurrenceCount");
    return occurrenceCount;
  }
}
