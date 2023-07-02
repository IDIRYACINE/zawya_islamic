

import 'package:flutter/material.dart';

typedef WidgetBuilder = Widget Function(int index); 

class AppSetupOptions{

  final WidgetBuilder bodyBuilder;
  final WidgetBuilder bottomNavigationBarBuilder;

  const AppSetupOptions({
    required this.bodyBuilder,
    required this.bottomNavigationBarBuilder,
  });

}