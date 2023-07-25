import 'package:zawya_islamic/resources/loaded.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.height, this.width});

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child:  SvgPicture(
        LoadedAppResources.logoBlack,
      ),
    );
  }
}
