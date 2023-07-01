import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/admin_app/schools/state/bloc.dart';
import 'package:zawya_islamic/application/admin_app/schools/state/events.dart';
import 'package:zawya_islamic/core/aggregates/school.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:uuid/uuid.dart';

//TODO : make call to infrastructure

class SchoolEditorController {
  static final key = GlobalKey<FormState>();

  SchoolEditorController([String? schoolName]) {
    this.schoolName = schoolName ?? "";
  }

  late String schoolName;

  void updateName(String value) {
    schoolName = value;
  }

  void createOrUpdate(School? school) {
    final isValid = key.currentState!.validate();

    if (isValid) {
      if (school != null) {
        _updateSchool(school);
        return;
      }

      _createSchool();
    }
  }


  void _updateSchool(School school){
    final updatedSchool = school.copyWith(
      name: Name(schoolName)
    );

    final event = UpdateSchoolEvent(school: updatedSchool);
    final bloc = BlocProvider.of<SchoolsBloc>(key.currentContext!);
    
    bloc.add(event);
  }

  void _createSchool(){
    final school = School(name: Name(schoolName), id: SchoolId(const Uuid().v4())) ;
    final bloc = BlocProvider.of<SchoolsBloc>(key.currentContext!);

    final event = CreateSchoolEvent(school: school);

    bloc.add(event);

  }
}
