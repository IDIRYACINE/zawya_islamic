import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/features/layout/logic/ports.dart';
import 'package:zawya_islamic/application/features/login/feature.dart';
import 'package:zawya_islamic/application/teacher_app/evaluation/ui/evaluation_view.dart';
import 'package:zawya_islamic/application/teacher_app/presence/ui/presence_view.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/resources/resources.dart';

typedef OnSelect = void Function(int index, AppBloc bloc);

class TeacherBottomNavigationBar extends StatelessWidget {
  const TeacherBottomNavigationBar({
    super.key,
    required this.selectedIndex,
  });

  final int selectedIndex;

  void onSelect(int index, AppBloc bloc) {
    bloc.add(NavigateIndexEvent(index));
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final bloc = BlocProvider.of<AppBloc>(context);

    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) => onSelect(index, bloc),
      items: [
        BottomNavigationBarItem(
          icon: const Icon(AppResources.presenceIcon),
          label: localizations.presenceLabel,
        ),
        BottomNavigationBarItem(
          icon: const Icon(AppResources.evaluationIcon),
          label: localizations.evaluationLabel,
        ),
       
      ],
    );
  }
}

class TeacherAppSetupOptions extends AppSetupOptions {
  const TeacherAppSetupOptions()
      : super(
          bodyBuilder: buildBody,
          bottomNavigationBarBuilder: buildBottomNavigationBar,
          dataLoader:teacherDataLoader
        );

  static Widget buildBottomNavigationBar(int index) {
    return TeacherBottomNavigationBar(
      selectedIndex: index,
    );
  }

  static void teacherDataLoader(BuildContext context) {
    
  }

  static Widget buildBody(int pageIndex) {
    switch (pageIndex) {
      case 0:
        return const PresenceView(
          displayAppBar: false,
        );

      default:
        return const EvaluationView(
          displayAppBar: false,
        );
    }
  }
  
}
