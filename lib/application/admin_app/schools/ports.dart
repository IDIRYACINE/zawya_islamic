
import 'package:flutter/material.dart';
import 'package:zawya_islamic/core/aggregates/school.dart';

abstract class SchoolCardControllerPort {
  void onClick(School school);
  void onMoreActions( School school,);
  
  bool get displayFloatingAction;

  bool get displayOnMoreActions;

  
  void onFloatingClick() ;

  Future<bool>  onSwipe(School school, BuildContext context) ;
}