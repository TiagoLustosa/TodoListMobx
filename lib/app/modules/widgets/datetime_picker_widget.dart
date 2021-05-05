import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_app/app/modules/widgets/button_widget.dart';

class DateTimePickerWidget extends StatefulWidget {
  @override
  _DateTimePickerWidgetState createState() => _DateTimePickerWidgetState();
}

class _DateTimePickerWidgetState extends State<DateTimePickerWidget> {
  DateTime dateTime;

  String getText() {
    if (dateTime == null) {
      return 'Selecione a data';
    } else {
      return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ButtonHeaderWidget(
      title: 'DateTime',
      text: getText(),
      onClicked: () => pickDateTime(context),
    );
  }

  Future pickDateTime(BuildContext context) async {
    final date = await pickDate(context);
    if (date == null) return;
    final time = await pickTime(context);

    setState(() {
      dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  Future<DateTime> pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: dateTime ?? initialDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2021, 12, 31));
    if (newDate == null) return null;
    return newDate;
  }

  Future<TimeOfDay> pickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 00, minute: 00);
    final newTime = await showTimePicker(
      context: context,
      initialTime: dateTime != null
          ? TimeOfDay(hour: dateTime.hour, minute: dateTime.minute)
          : initialTime,
    );
    if (newTime == null) return null;
    return newTime;
  }
}
