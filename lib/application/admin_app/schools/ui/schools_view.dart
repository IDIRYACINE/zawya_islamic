import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/admin_app/schools/state/export.dart';
import 'package:zawya_islamic/application/admin_app/schools/ui/school_editor.dart';
import 'package:zawya_islamic/application/features/login/feature.dart';
import 'package:zawya_islamic/application/features/navigation/feature.dart';
import 'package:zawya_islamic/core/aggregates/school.dart';
import 'package:zawya_islamic/core/ports/school_service_port.dart';
import 'package:zawya_islamic/infrastructure/exports.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/resources/measures.dart';
import 'package:zawya_islamic/resources/resources.dart';
import 'package:zawya_islamic/widgets/dialogs.dart';

import '../logic/school_card_controller.dart';

class SchoolCard extends StatelessWidget {
  final School school;

  const SchoolCard({super.key, required this.school});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final bloc = BlocProvider.of<SchoolsBloc>(context);
    final appBloc = BlocProvider.of<AppBloc>(context);

    final SchoolCardController controller =
        SchoolCardController(school, bloc, appBloc);

    return SizedBox(
      height: 75,
      child: InkWell(
        onTap: controller.onClick,
        child: Center(
          child: ListTile(
            leading: Text(school.name.value),
            trailing: OptionsButton(
                onClick: () => controller.onMoreActions(localizations)),
          ),
        ),
      ),
    );
  }
}

class SchoolsView extends StatelessWidget {
  const SchoolsView({super.key});

  Widget _buildItems(BuildContext context, School school) {
    return SchoolCard(school: school);
  }

  void _onAddSchool() {
    const dialog = SchoolEditorDialog();
    NavigationService.displayDialog(dialog);
  }

  void _loadSchools(BuildContext context) {
    final schoolsBloc = BlocProvider.of<SchoolsBloc>(context);

    final schoolOptions = LoadSchoolsOptions();
    ServicesProvider.instance()
        .schoolService
        .getSchools(schoolOptions)
        .then((res) => schoolsBloc.add(LoadSchoolsEvent(schools: res.data)));
  }

  Widget _seperatorBuilder(BuildContext context, int index) {
    return const SizedBox(
      height: 20,
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    _loadSchools(context);

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
             
            BlocProvider.of<AppBloc>(context).add(LogoutEvent());

            NavigationService.pushNamedReplacement(Routes.loginRoute);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: Text(localizations.schoolListLabel),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppMeasures.paddings),
        child: BlocBuilder<SchoolsBloc, SchoolState>(
          builder: (context, state) {
            return ListView.separated(
              separatorBuilder: _seperatorBuilder,
              itemCount: state.schools.length,
              itemBuilder: (context, index) =>
                  _buildItems(context, state.schools[index]),
            );
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(AppMeasures.paddings),
        child: ElevatedButton(
          onPressed: _onAddSchool,
          child: const Icon(AppResources.addIcon),
        ),
      ),
    );
  }
}
