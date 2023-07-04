import 'package:flutter/material.dart';

import 'presence_tabs.dart';

class PresenceView extends StatelessWidget {
  const PresenceView({super.key, this.displayAppBar = true});
  final bool displayAppBar;

  @override
  Widget build(BuildContext context) {
    return const StudentPresenceTab();
  }
}
