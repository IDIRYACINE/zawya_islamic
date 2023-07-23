
import 'package:flutter/material.dart';

String formatDateTimeToDisplay(DateTime date){
  return  '${date.day}/${date.month}/${date.year}';
}


String formatDayTime(TimeOfDay time){
    final hoursStr = time.hour.toString().padLeft(2, '0');
        final minutesStr = time.minute.toString().padLeft(2, '0');

        return '$hoursStr:$minutesStr';
}