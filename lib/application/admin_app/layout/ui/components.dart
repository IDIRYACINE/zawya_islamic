import 'package:flutter/material.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/resources/resources.dart';

typedef OnSelect = void Function(int index);

class AdminBottomNavigationBar extends StatelessWidget {
  const AdminBottomNavigationBar(
      {super.key, required this.selectedIndex, required this.onSelect});

  final int selectedIndex;
  final OnSelect onSelect;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onSelect,
      items: [
         BottomNavigationBarItem(
          icon: const Icon(AppResources.studentIcon),
          label: localizations.studentsLabel,
        ),
         BottomNavigationBarItem(
          icon: const Icon(AppResources.teacherIcon),
          label: localizations.teachersLabel,
        ),
        BottomNavigationBarItem(
          icon: const Icon(AppResources.groupIcon),
          label: localizations.groupsLabel,
        ),
      ],
    );
  }
}
