// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../extraFunctions.dart';

class CustomCalendar extends StatefulWidget {
  CustomCalendar({
    super.key,
    this.active = const [],
    this.inactive = const [],
    required this.onCalendarChanged,
  });
  List<DateTime> active;
  List<DateTime> inactive;
  final Function(List<DateTime>) onCalendarChanged;
  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime _currentDate = DateTime.now();
  DateTime today = DateTime.now();
  bool isDateInActiveList(DateTime targetDate) {
    return widget.active.any((date) => isSameDate(date, targetDate));
  }

  bool isDateIninActiveList(DateTime targetDate) {
    return widget.inactive.any((date) => isSameDate(date, targetDate));
  }

  bool isDateWithinRange(DateTime date) {
    DateTime minDate = DateTime.now().add(const Duration(days: 1));
    DateTime maxDate = DateTime.now().add(const Duration(days: 30));
    DateTime minDateWithoutTime = DateTime(minDate.year, minDate.month, minDate.day);
    DateTime maxDateWithoutTime = DateTime(maxDate.year, maxDate.month, maxDate.day);
    DateTime dateWithoutTime = DateTime(date.year, date.month, date.day);
    return dateWithoutTime.isAtSameMomentAs(minDateWithoutTime) || dateWithoutTime.isAfter(minDateWithoutTime) && dateWithoutTime.isBefore(maxDateWithoutTime);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Column(children: [buildHeader(), buildWeekdayHeader(), buildCalendar()]),
    );
  }

  Widget buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            setState(() {
              if (_currentDate.month == DateTime.now().month + 1) {
                _currentDate = DateTime(_currentDate.year, _currentDate.month - 1);
              }
            });
          },
        ),
        Text(
          DateFormat.yMMMM().format(_currentDate),
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: () {
            setState(() {
              if (_currentDate.month == DateTime.now().month) {
                _currentDate = DateTime(_currentDate.year, _currentDate.month + 1);
              }
            });
          },
        ),
      ],
    );
  }

  Widget buildWeekdayHeader() {
    final List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
            children: weekdays
                .map((day) => Expanded(
                        child: Center(
                            child: Text(
                      day,
                      textScaler: TextScaler.noScaling,
                    ))))
                .toList()));
  }

  Widget buildCalendar() {
    final DateTime firstDayOfMonth = DateTime(_currentDate.year, _currentDate.month, 1);
    final int daysInMonth = DateTime(_currentDate.year, _currentDate.month + 1, 0).day;
    final int weekdayOfFirstDay = firstDayOfMonth.weekday;

    List<Widget> calendarDays = [];

    DateTime currentDate = firstDayOfMonth;
    for (int i = 1; i <= daysInMonth + weekdayOfFirstDay - 1; i++) {
      if (i < weekdayOfFirstDay) {
        calendarDays.add(Container());
      } else {
        DateTime dayToShow = currentDate;
        calendarDays.add(
          isDateWithinRange(dayToShow)
              ? InkWell(
                  onTap: () {
                    if (isDateInActiveList(dayToShow)) {
                      if (isDateIninActiveList(dayToShow)) {
                        List<DateTime> updatedInactive = List.from(widget.inactive);
                        updatedInactive.removeWhere((date) => isSameDate(date, dayToShow));
                        setState(() => widget.inactive = updatedInactive);
                      } else {
                        List<DateTime> updatedInactive = List.from(widget.inactive);
                        updatedInactive.add(dayToShow);
                        setState(() => widget.inactive = updatedInactive);
                      }
                      widget.onCalendarChanged(widget.inactive);
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.all(4.0),
                    padding: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      color: isDateIninActiveList(dayToShow)
                          ? Colors.red
                          : isDateInActiveList(dayToShow)
                              ? Colors.green
                              : Colors.white,
                      borderRadius: BorderRadius.circular(12.27),
                      boxShadow: isDateInActiveList(dayToShow) ? [const BoxShadow(color: Color(0x24695F97), blurRadius: 10.46, offset: Offset(1, 5.69), spreadRadius: 0)] : [],
                    ),
                    child: Center(
                        child: Text(DateFormat('d').format(currentDate), textScaler: TextScaler.noScaling, style: TextStyle(color: isDateInActiveList(dayToShow) ? Colors.white : null, fontSize: 10))),
                  ),
                )
              : Container(
                  margin: const EdgeInsets.all(4.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12.27)),
                  child: Center(child: Text(DateFormat('d').format(dayToShow), textScaler: TextScaler.noScaling, style: const TextStyle(color: Color(0xFFC0BDCC), fontSize: 12))),
                ),
        );
        currentDate = currentDate.add(const Duration(days: 1));
      }
    }

    return GridView.count(
      physics: const ScrollPhysics(parent: NeverScrollableScrollPhysics()),
      crossAxisCount: 7,
      shrinkWrap: true,
      children: calendarDays,
    );
  }
}
