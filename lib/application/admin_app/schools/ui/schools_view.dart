import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/admin_app/schools/logic/school_card_controller.dart';
import 'package:zawya_islamic/application/admin_app/schools/ports.dart';
import 'package:zawya_islamic/application/admin_app/schools/state/export.dart';
import 'package:zawya_islamic/application/features/login/feature.dart';
import 'package:zawya_islamic/application/features/navigation/feature.dart';
import 'package:zawya_islamic/core/aggregates/school.dart';
import 'package:zawya_islamic/core/ports/school_service_port.dart';
import 'package:zawya_islamic/infrastructure/exports.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/resources/measures.dart';
import 'package:zawya_islamic/resources/resources.dart';

class SchoolCard extends StatelessWidget {
  final School school;

  const SchoolCard({super.key, required this.school, required this.controller});
  final SchoolCardControllerPort controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: InkWell(
        onTap: () => controller.onClick(school),
        child: Card(
          child: Center(child: Text(school.name.value)),
        ),
      ),
    );
  }
}

class SchoolsView extends StatelessWidget {
  const SchoolsView({super.key, this.controllerPort});

  final SchoolCardControllerPort? controllerPort;

  Widget _buildItems(SchoolCardControllerPort controller, School school) {
    return SchoolCard(
      school: school,
      controller: controller,
    );
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
    final bloc = BlocProvider.of<SchoolsBloc>(context);
    final appBloc = BlocProvider.of<AppBloc>(context);

    final SchoolCardControllerPort controller = controllerPort ??
        SchoolCardController(
          bloc,
          appBloc,
          localizations,
        );

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
                  _buildItems(controller, state.schools[index]),
            );
          },
        ),
      ),
      floatingActionButton: controller.displayFloatingAction
          ? Padding(
              padding: const EdgeInsets.all(AppMeasures.paddings),
              child: ElevatedButton(
                onPressed: controller.onFloatingClick,
                child: const Icon(AppResources.addIcon),
              ),
            )
          : null,
    );
  }
}
