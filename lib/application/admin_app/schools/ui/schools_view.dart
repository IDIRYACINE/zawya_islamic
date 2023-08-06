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
import 'package:zawya_islamic/resources/loaded.dart';
import 'package:zawya_islamic/resources/measures.dart';
import 'package:zawya_islamic/widgets/buttons.dart';
import 'package:zawya_islamic/widgets/dialogs.dart';
import 'package:zawya_islamic/widgets/images.dart';

class SchoolCard extends StatelessWidget {
  final School school;

  const SchoolCard({super.key, required this.school, required this.controller});
  final SchoolCardControllerPort controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppMeasures.cardHeight,
      child: InkWell(
        onTap: () => controller.onClick(school),
        child: Card(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                AccentIcon(
                  iconDataBytes: LoadedAppResources.mosqueWhite,
                ),
                Text(school.name.value),
                controller.displayOnMoreActions
                    ? OptionsButton(
                        onClick: () => controller.onMoreActions(school),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SchoolsView extends StatelessWidget {
  const SchoolsView({super.key, this.controllerPort});

  final SchoolCardControllerPort? controllerPort;

  Widget _buildItems(BuildContext context, SchoolCardControllerPort controller,
      School school) {
    return SchoolCard(
      school: school,
      controller: controller,
    );
  }

  Widget _buildSwipableItem(BuildContext context,
      SchoolCardControllerPort controller, School school) {
    final key = Key(school.id.value);

    return Dismissible(
      key: key,
      confirmDismiss: (direction) => controller.onSwipe(school, context),
      child: SchoolCard(
        school: school,
        controller: controller,
      ),
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

    final builder =
        controller.displayOnMoreActions ? _buildSwipableItem : _buildItems;

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
            if (state.schools.isEmpty) {
              return Center(child: Text(localizations.emptySchoolsListLabel));
            }
            return ListView.separated(
              separatorBuilder: _seperatorBuilder,
              itemCount: state.schools.length,
              itemBuilder: (context, index) =>
                  builder(context, controller, state.schools[index]),
            );
          },
        ),
      ),
      floatingActionButton: controller.displayFloatingAction
          ? AddButton(
              onPressed: controller.onFloatingClick,
            )
          : null,
    );
  }
}
