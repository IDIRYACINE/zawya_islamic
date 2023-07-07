

import 'package:flutter/material.dart';

typedef WidgetBuilder = Widget Function(int index); 
typedef SplashDataLoader = void Function(BuildContext context);

class AppSetupOptions{

  final WidgetBuilder bodyBuilder;
  final WidgetBuilder bottomNavigationBarBuilder;
  final SplashDataLoader? dataLoader;

  const AppSetupOptions({
    required this.bodyBuilder,
    this.dataLoader,
    required this.bottomNavigationBarBuilder,
  });

}