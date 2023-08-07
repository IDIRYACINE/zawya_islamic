import 'package:flutter/material.dart';
import 'package:zawya_islamic/application/features/navigation/navigation_service.dart';
import 'package:zawya_islamic/application/features/students/export.dart';
import 'package:zawya_islamic/application/teacher_app/evaluation/ui/evaluation_form.dart';
import 'package:zawya_islamic/application/teacher_app/evaluation/ui/evaluation_view.dart';
import 'package:zawya_islamic/core/entities/evaluations.dart';
import 'package:zawya_islamic/core/entities/presence.dart';
import 'package:zawya_islamic/core/entities/quran.dart';
import 'package:zawya_islamic/core/ports/student_service_port.dart';
import 'package:zawya_islamic/infrastructure/services/services_provider.dart';

import 'data.dart';

class EvaluationFormController {
  static final formKey = GlobalKey<FormState>();

  static final widgetKey = GlobalKey<EvaluationFormState>();

  EvaluationFormController(this.studentEvaluationAndPresence, this.studentBloc);
  final StudentEvaluationAndPresence studentEvaluationAndPresence;
  final StudentsBloc studentBloc;

  final TextEditingController suratNameController = TextEditingController();
  final TextEditingController suratNumberController = TextEditingController();

  Surat? surat;
  int? startAyat;
  int? endAyat;

  void onSelectSuratFromList() {
    const dialog = SuratListSelector();

    NavigationService.displayDialog<Surat?>(dialog).then((value) {
      if (value != null) {
        surat = value;
        suratNameController.text = value.name;
        suratNumberController.text = value.suratNumber.toString();
        widgetKey.currentState!.updateSurat(surat);
      }
    });
  }

  void onSuratNumber(String? num) {
    int? parsedNum = int.tryParse(num ?? "-1");

    final validNum = _validSuratNum(parsedNum);
    surat = validNum ? _searchSuratByNum(parsedNum!) : null;
    suratNameController.text = surat?.name ?? "";

    widgetKey.currentState!.updateSurat(surat);
  }

  void setStartAyat(String? ayatNum) {
    startAyat = int.tryParse(ayatNum ?? "-1");
  }

  void setEndAyat(String? ayatNum) {
    endAyat = int.tryParse(ayatNum ?? "-1");
  }

  void registerStudentMemorization() {
    final didMemorize = startAyat != null && endAyat != null;

    if (!didMemorize) {
      return;
    }

    

    Evaluation evaluation = Evaluation(
      surat: surat!,
      start: Ayat.fromNumber(startAyat!, surat!.ayatCount),
      end: Ayat.fromNumber(endAyat!, surat!.ayatCount),
    );

    final newStudentEvaluation = StudentEvaluation(
        studentId: studentEvaluationAndPresence.student.id,
        evaluation: evaluation);

    final event = MarkStudentEvaluation(
        evaluation: studentEvaluationAndPresence.copyWith(
            evaluation: newStudentEvaluation));

    studentBloc.add(event);

    final options = MarkEvaluationOptions(
      evaluation: newStudentEvaluation,
    );

    ServicesProvider.instance().studentService.markMonthlyEvaluation(options);

    NavigationService.pop();
  }

  void registerStudentZeroMemorization() {
    Evaluation evaluation = Evaluation(
      surat: surat!,
    );

    final newStudentEvaluation = StudentEvaluation(
        studentId: studentEvaluationAndPresence.student.id,
        evaluation: evaluation);

    studentEvaluationAndPresence.copyWith(evaluation: newStudentEvaluation);
    final event =
        MarkStudentEvaluation(evaluation: studentEvaluationAndPresence);

    studentBloc.add(event);
    NavigationService.pop();
  }

  Surat _searchSuratByNum(int num) {
    final rawSurat = suwarList[num - 1];

    return rawSurat;
  }

  bool _validSuratNum(int? parsedNum) {
    if (parsedNum == null) {
      return false;
    }
    final inSuratNumRange = parsedNum > 0 && parsedNum < 115;

    return inSuratNumRange;
  }
}
