import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:zawya_islamic/application/features/layout/state/bloc.dart';
import 'package:zawya_islamic/application/features/navigation/feature.dart';
import 'package:zawya_islamic/application/features/students/export.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/core/ports/student_service_port.dart';
import 'package:zawya_islamic/infrastructure/exports.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/widgets/dialogs.dart';

void startSession(BuildContext context) {
  final studentBloc = BlocProvider.of<StudentsBloc>(context);
  final teacherId = BlocProvider.of<AppBloc>(context).state.user!.toTeacherId();

  final session =
      Session(id: SessionId(const Uuid().v4()), teacherId: teacherId);

  final event = SetSessionEvent(session: session);
  studentBloc.add(event);
}

void closeSession(BuildContext context) {
  final studentBloc = BlocProvider.of<StudentsBloc>(context);
  final localizations = AppLocalizations.of(context)!;

  final dialog = ConfirmationDialog(
      onConfirm: () {
        final event = SetSessionEvent(session: null, nullify: true);
        studentBloc.add(event);

        NavigationService.pop();
      },
      title: localizations.closeSessionLabel,
      content: localizations.permanentActionWarning);

  NavigationService.displayDialog(dialog);
}

void updateMonthlyPresence(List<StudentPresence> presence) {
  final options = MarkPresenceOptions(presences: presence);

  ServicesProvider.instance().studentService.markPresenceOrAbsence(options);
}
