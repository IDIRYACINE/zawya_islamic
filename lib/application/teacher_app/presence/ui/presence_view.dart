import 'package:flutter/material.dart';
import 'package:zawya_islamic/resources/l10n/l10n.dart';
import 'package:zawya_islamic/widgets/buttons.dart';

import '../logic/helpers.dart';
import 'presence_tabs.dart';

class PresenceView extends StatelessWidget {
  const PresenceView({super.key, this.displayAppBar = true});
  final bool displayAppBar;

  @override
  Widget build(BuildContext context) {
    return const StudentPresenceTab();
  }
}


class NoSessionView extends StatelessWidget{
  const NoSessionView({super.key});



  @override
  Widget build(BuildContext context) {

    final localizations = AppLocalizations.of(context)!;

    return Center(child: 
      ButtonPrimary(onPressed: () => startSession(context), text: localizations.createSessionLabel)
    );
  }

} 