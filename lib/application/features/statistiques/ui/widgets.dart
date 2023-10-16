import 'package:flutter/material.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/resources/measures.dart';
import 'package:zawya_islamic/resources/resources.dart';

class EvaluationRowWidget extends StatelessWidget {
  const EvaluationRowWidget({super.key, required this.evaluation});

  final Evaluation evaluation;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text("${localizations.surat} : ${evaluation.suratName}"),
        Text("${localizations.ayat} : ${evaluation.ayatNumber}"),
      ],
    );
  }
}

class PresenseMeterWidget extends StatelessWidget {
  const PresenseMeterWidget({super.key, required this.presence});

  final StudentPresence presence;

  Widget _seperatorBuilder(BuildContext context, int index) {
    return const SizedBox(
      width: AppMeasures.paddingsSmall,
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return Icon(
      AppResources.presenceCircleIcon,
      color: index < presence.presence.modifer ? Colors.green : Colors.red,
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final itemsCount = presence.totalPresenceCount;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(localizations.presenceLabel),
        Expanded(
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: _itemBuilder,
            itemCount: itemsCount,
            separatorBuilder: _seperatorBuilder,
          ),
        )
      ],
    );
  }
}
