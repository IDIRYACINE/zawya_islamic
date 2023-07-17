import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/features/students/state/bloc.dart';
import 'package:zawya_islamic/application/features/students/state/state.dart';
import 'package:zawya_islamic/application/teacher_app/presence/ui/presence_view.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';

import '../logic/presence_card_controller.dart';

class StudentPresenceTab extends StatefulWidget {
  const StudentPresenceTab({super.key});

  @override
  State<StatefulWidget> createState() => _StudentPresenceTabState();
}

class _StudentPresenceTabState extends State<StudentPresenceTab> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return BlocBuilder<StudentsBloc, StudentsState>(builder: (context, state) {
      if (state.session == null) {
        return const NoSessionView();
      }

      return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: TabBar(
              tabs: [
                Tab(text: localizations.absenceLabel),
                Tab(text: localizations.presenceLabel)
              ],
            ),
          ),
          body: TabBarView(children: [
            PresenceTabView(
              students: state.absence,
              isPresent: false,
            ),
            PresenceTabView(
              students: state.presence,
            ),
          ]),
        ),
      );
    });
  }
}

class PresenceCard extends StatelessWidget {
  const PresenceCard(
      {super.key,
      required this.student,
      required this.isPresent,
      required this.controller});

  final Student student;
  final bool isPresent;
  final PresenceCardController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => controller.onTap(student, !isPresent),
        child: ListTile(
          leading: Text(student.name.value),
          trailing: Switch(
              value: isPresent,
              onChanged: (value) => controller.onTap(student, value)),
        ),
      ),
    );
  }
}

class PresenceTabView extends StatelessWidget {
  const PresenceTabView(
      {super.key, required this.students, this.isPresent = true});

  final List<Student> students;
  final bool isPresent;

  Widget _buildItem(BuildContext context, Student student,
      PresenceCardController presenceCardController) {
    return PresenceCard(
      student: student,
      isPresent: isPresent,
      controller: presenceCardController,
    );
  }

  Widget _speperatorBuilder(BuildContext context, int index) {
    return const SizedBox(
      height: 20,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<StudentsBloc>(context);
    final presenceCardController = PresenceCardController(bloc);

    return ListView.separated(
        itemBuilder: (context, index) =>
            _buildItem(context, students[index], presenceCardController),
        separatorBuilder: _speperatorBuilder,
        itemCount: students.length);
  }
}
