import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/admin_app/schools/state/bloc.dart';
import 'package:zawya_islamic/application/admin_app/schools/state/events.dart';
import 'package:zawya_islamic/application/features/navigation/feature.dart';
import 'package:zawya_islamic/core/aggregates/school.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:uuid/uuid.dart';
import 'package:zawya_islamic/core/ports/school_service_port.dart';
import 'package:zawya_islamic/infrastructure/exports.dart';

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
      }
      else{
      _createSchool();

      }
      NavigationService.pop();
    }
  }

  void _updateSchool(School school) {
    final updatedSchool = school.copyWith(name: Name(schoolName));
    final bloc = BlocProvider.of<SchoolsBloc>(key.currentContext!);

    final options = UpdateSchoolOptions(school: updatedSchool);
    ServicesProvider.instance().schoolService.updateSchool(options).then(
          (res) => bloc.add(
            UpdateSchoolEvent(school: updatedSchool),
          ),
        );
  }

  void _createSchool() {
    final bloc = BlocProvider.of<SchoolsBloc>(key.currentContext!);

    final school = School(
      name: Name(schoolName),
      id: SchoolId(
        const Uuid().v4(),
      ),
    );

    final options = RegisterSchoolOptions(school: school);
    ServicesProvider.instance().schoolService.registerSchool(options).then(
          (res) => bloc.add(
            CreateSchoolEvent(school: school),
          ),
        );
  }
}
