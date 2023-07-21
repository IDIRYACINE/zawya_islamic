import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:zawya_islamic/application/features/layout/state/bloc.dart';
import 'package:zawya_islamic/application/features/students/export.dart';
import 'package:zawya_islamic/core/entities/session.dart';
import 'package:zawya_islamic/core/ports/student_service_port.dart';
import 'package:zawya_islamic/infrastructure/services/services_provider.dart';

void startSession(BuildContext context) {
  final studentBloc = BlocProvider.of<StudentsBloc>(context);
  final teacherId = BlocProvider.of<AppBloc>(context).state.user!.toTeacherId();

  final session =
      Session(id: SessionId(const Uuid().v4()), teacherId: teacherId);

  final event = SetSession(session: session);
  studentBloc.add(event);
}


void closeSession(BuildContext context) {
  final studentBloc = BlocProvider.of<StudentsBloc>(context);

  final event = SetSession(session: null,nullify: true);
  studentBloc.add(event);


  final presence = studentBloc.state.presenceAndEvaluation.map((e) => e.presence).toList();

  final options = MarkPresenceOptions(presences: presence);

  ServicesProvider.instance().studentService.markPresenceOrAbsence(options);

}

