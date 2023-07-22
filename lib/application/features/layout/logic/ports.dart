

import 'package:flutter/material.dart';

typedef WidgetBuilder = Widget Function(int index); 
typedef AppbarBuilder = PreferredSizeWidget Function(BuildContext context);
typedef SplashDataLoader = void Function(BuildContext context);

class AppSetupOptions{

  final WidgetBuilder bodyBuilder;
  final WidgetBuilder bottomNavigationBarBuilder;
  final AppbarBuilder? appbarBuilder;
  final SplashDataLoader? dataLoader;

  const AppSetupOptions( {
    this.appbarBuilder,
    required this.bodyBuilder,
    this.dataLoader,
    required this.bottomNavigationBarBuilder,
  });

}