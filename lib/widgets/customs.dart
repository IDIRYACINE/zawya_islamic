import 'package:flutter/material.dart';
import 'package:zawya_islamic/resources/loaded.dart';

class BackgroundPattern extends StatelessWidget {
  const BackgroundPattern({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
        image: LoadedAppResources.backgroundImageAsset,
      )),
      child: child,
    );
  }
}
