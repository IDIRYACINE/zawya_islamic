import 'package:flutter/material.dart';

class EvaluationView extends StatelessWidget {
  const EvaluationView({super.key,  this.displayAppBar = true});

  final bool displayAppBar;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("onProgress")),
    );
  }
}
