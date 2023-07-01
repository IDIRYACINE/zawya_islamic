import 'package:flutter/material.dart';
import 'package:zawya_islamic/application/admin_app/students/ui/students_view.dart';
import 'package:zawya_islamic/application/admin_app/teachers/ui/teacher_view.dart';

import 'components.dart';

class AdminAppLayout extends StatefulWidget {
  const AdminAppLayout({super.key});

  @override
  State<StatefulWidget> createState() => _AdminAppLayoutState();
}

class _AdminAppLayoutState extends State<AdminAppLayout> {
  int pageIndex = 0;

  Widget _buildBody() {
    switch (pageIndex) {
      case 0:
        return const StudentsView(
          displayAppBar: false,
        );

      default:
        return const TeachersView(
          displayAppBar: false,
        );
    }
  }

  void _updateIndex(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: _buildBody(),
      bottomNavigationBar: AdminBottomNavigationBar(
        onSelect: _updateIndex,
        selectedIndex: pageIndex,
      ),
    );
  }
}
