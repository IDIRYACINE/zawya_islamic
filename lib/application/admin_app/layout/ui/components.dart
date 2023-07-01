import 'package:flutter/material.dart';
import 'package:zawya_islamic/resources/resources.dart';

typedef OnSelect = void Function(int index);

class AdminBottomNavigationBar extends StatelessWidget {
  const AdminBottomNavigationBar(
      {super.key, required this.selectedIndex, required this.onSelect});

  final int selectedIndex;
  final OnSelect onSelect;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onSelect,
      items: const[
         BottomNavigationBarItem(
          icon: Icon(AppResources.studentIcon),
          label: "students"
        ),
         BottomNavigationBarItem(
          icon: Icon(AppResources.teacherIcon),
          label:"teachers"
        ),
      ],
    );
  }
}
