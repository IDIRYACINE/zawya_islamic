import 'package:flutter/material.dart';

class GroupScheduleController {

  

  Future<void> displaTimePickerDialog(
      BuildContext context, TimeOfDay initialTime) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if(pickedTime !=null){

    }
  }
}
