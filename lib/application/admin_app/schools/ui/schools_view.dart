import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/admin_app/schools/state/export.dart';
import 'package:zawya_islamic/core/aggregates/school.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/resources/measures.dart';
import 'package:zawya_islamic/resources/resources.dart';

class SchoolCard extends StatelessWidget {
  final School school;

  const SchoolCard({super.key, required this.school});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Text(school.name.value),
    );
  }
}

class SchoolsView extends StatelessWidget {
  const SchoolsView({super.key});

  Widget _buildItems(BuildContext context, School school) {
    return SchoolCard(school: school);
  }

  void _onAddSchool() {
    
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.schoolListLabel),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<SchoolsBloc, SchoolState>(
              builder: (context, state) {
                return ListView.builder(
                    itemCount: state.schools.length,
                    itemBuilder: (context, index) =>
                        _buildItems(context, state.schools[index]));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppMeasures.paddings),
            child: ElevatedButton(
              onPressed: _onAddSchool,
              child: const Icon(AppResources.addIcon),
            ),
          ),
        ],
      ),
    );
  }
}
