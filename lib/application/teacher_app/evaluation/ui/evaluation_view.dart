import 'package:flutter/material.dart';
import 'package:zawya_islamic/application/features/navigation/navigation_service.dart';
import 'package:zawya_islamic/application/teacher_app/evaluation/logic/data.dart';

import 'evaluation_tabs.dart';

class EvaluationView extends StatelessWidget {
  const EvaluationView({super.key, this.displayAppBar = true});
  final bool displayAppBar;

  @override
  Widget build(BuildContext context) {
    return const MonthyEvaluationTab();
  }
}

class SuratListSelector extends StatelessWidget {
  const SuratListSelector({super.key});

  Widget _itemBuilder(BuildContext context, int index) {
    final surat = suwarList[index];

    return SizedBox(
      height: 80,
      child: ListTile(
        title: Text(surat.name),
        onTap: () => NavigationService.pop(surat),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
  return AlertDialog(
    content: SizedBox(
      width: MediaQuery.of(context).size.width * 0.8, 
      height: MediaQuery.of(context).size.height * 0.4, 
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: suwarList.length,
        itemBuilder: _itemBuilder,
      ),
    ),
  );
}

}
