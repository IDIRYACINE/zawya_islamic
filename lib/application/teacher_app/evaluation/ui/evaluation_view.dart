import 'package:flutter/material.dart';

import 'evaluation_tabs.dart';

class EvaluationView extends StatelessWidget {
  const EvaluationView({super.key, this.displayAppBar = true});
  final bool displayAppBar;

  @override
  Widget build(BuildContext context) {
    return const StudentEvaluationTab();
  }
}
