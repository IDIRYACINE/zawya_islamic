import 'package:flutter/material.dart';
import 'package:zawya_islamic/application/features/navigation/navigation_service.dart';
import 'package:zawya_islamic/application/features/students/export.dart';
import 'package:zawya_islamic/core/entities/evaluations.dart';
import 'package:zawya_islamic/core/entities/quran.dart';

class EvaluationFormController {
  static final formKey = GlobalKey<FormState>();

  EvaluationFormController(this.studentEvaluation, this.studentBloc);
  final StudentEvaluation studentEvaluation;
  final StudentsBloc studentBloc;

  TextEditingController suratNameController = TextEditingController();

  Surat? surat;
  int? startAyat;
  int? endAyat;

  void onSuratNumber(String? num) {
    //TODO implement search surat
    surat = Surat(suratNumber: 2, name: "البقرة", ayatCount: 286);
    suratNameController.text = surat?.name ?? "";
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
      registerStudentZeroMemorization();
      return;
    }

    EvaluationByAyat evaluation = EvaluationByAyat(
      surat: surat!,
      start: Ayat.fromNumber(startAyat!, surat!.ayatCount),
      end: Ayat.fromNumber(endAyat!, surat!.ayatCount),
    );

    final event = MarkStudentEvaluation(
        evaluation: StudentEvaluation(studentEvaluation.student, evaluation));

    studentBloc.add(event);

    NavigationService.pop();
  }

  void registerStudentZeroMemorization() {
     EvaluationByAyat evaluation = EvaluationByAyat(
      surat: surat!,
     
    );

    final event = MarkStudentEvaluation(
        evaluation: StudentEvaluation(studentEvaluation.student, evaluation));

    studentBloc.add(event);
    NavigationService.pop();
  }
}
