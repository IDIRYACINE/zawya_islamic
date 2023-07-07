import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawya_islamic/application/features/navigation/feature.dart';
import 'package:zawya_islamic/application/features/students/export.dart';
import 'package:zawya_islamic/application/teacher_app/evaluation/logic/evaluation_form_controller.dart';
import 'package:zawya_islamic/core/entities/evaluations.dart';
import 'package:zawya_islamic/core/entities/quran.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/resources/measures.dart';
import 'package:zawya_islamic/utility/validators.dart';
import 'package:zawya_islamic/widgets/buttons.dart';

typedef FormValidator = String? Function(String?);
typedef StringCallback = void Function(String?);

class EvaluationForm extends StatefulWidget {
  EvaluationForm({required this.student, required this.bloc})
      : super(key: EvaluationFormController.widgetKey);

  final StudentEvaluation student;
  final StudentsBloc bloc;

  @override
  State<EvaluationForm> createState() => EvaluationFormState();
}

class EvaluationFormState extends State<EvaluationForm> {
  Surat? surat;
  bool init = false;
  late AppLocalizations localizations;
  late EvaluationFormController controller;

  EvaluationFormState();

  void updateSurat(Surat? surat) {
    setState(() {
      this.surat = surat;
    });
  }



    Widget buildAyatForm() {
      if (surat == null) {
        return const SizedBox();
      }

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            child: AyatFormField(
              onChanged: controller.setStartAyat,
              surat: surat!,
              isStart: true,
            ),
          ),
          const SizedBox(
            width: AppMeasures.space,
          ),
          Flexible(
            child: AyatFormField(
                onChanged: controller.setEndAyat,
                surat: surat!,
                isStart: false),
          ),
        ],
      );
    }

    Widget buildActionButton(AppLocalizations localizations) {
      if (surat != null) {
        return ButtonPrimary(
          text: localizations.confirmLabel,
          onPressed: controller.registerStudentMemorization,
        );
      }
      return ButtonPrimary(
        text: localizations.didntMemoreizeAnything,
        onPressed: controller.registerStudentZeroMemorization,
      );
    }

  @override
  Widget build(BuildContext context) {
    if (!init) {
      localizations = AppLocalizations.of(context)!;
      controller = EvaluationFormController(
        widget.student,
        widget.bloc,
      );
      init = true;
    }

    return Form(
      key: EvaluationFormController.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SuratFormField(
              onChanged: controller.onSuratNumber,
              suratNameController: controller.suratNameController),
          const SizedBox(
            height: AppMeasures.space,
          ),
          Flexible(child: buildAyatForm()),
          const SizedBox(
            height: AppMeasures.space,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ButtonPrimary(
                text: localizations.cancelLabel,
                onPressed: () => NavigationService.pop(),
              ),
              buildActionButton(localizations),
            ],
          )
        ],
      ),
    );
  }
}

class SuratFormField extends StatelessWidget {
  const SuratFormField(
      {super.key, required this.onChanged, required this.suratNameController});

  final StringCallback onChanged;
  final TextEditingController suratNameController;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Row(
      children: [
        Flexible(
          child: TextFormField(
            decoration: InputDecoration(
                labelText: "${localizations.number} ${localizations.alSurat}"),
            onChanged: onChanged,
            validator: (value) => suratFormValidator(value, localizations),
          ),
        ),
        const SizedBox(
          width: AppMeasures.space,
        ),
        Flexible(
          child: TextFormField(
            readOnly: true,
            controller: suratNameController,
          ),
        ),
      ],
    );
  }
}

class AyatFormField extends StatelessWidget {
  const AyatFormField(
      {super.key, required this.onChanged, required this.surat, this.isStart});

  final StringCallback onChanged;
  final Surat surat;
  final bool? isStart;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    final isRealStart = (isStart != null) && isStart!;
    final isRealEnd = (isStart != null) && !isStart!;

    String auxilaryText = "";

    auxilaryText = isRealStart ? localizations.start : auxilaryText;
    auxilaryText = isRealEnd ? localizations.end : auxilaryText;

    return TextFormField(
      decoration: InputDecoration(
          labelText:
              "$auxilaryText ${localizations.number} ${localizations.ayat}"),
      onChanged: onChanged,
      validator: (value) =>
          ayatFormValidator(value, surat.ayatCount, localizations),
    );
  }
}

class EvaluationDialog extends StatelessWidget {
  const EvaluationDialog({super.key, required this.student});

  final StudentEvaluation student;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<StudentsBloc>(context);

    return AlertDialog(
      content: EvaluationForm(student: student, bloc: bloc),
    );
  }
}
