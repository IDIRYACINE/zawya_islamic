

import 'package:flutter/material.dart';
import 'package:zawya_islamic/resources/themes.dart';

class OnSurfaceText extends StatelessWidget{
  final String text;
  final TextStyle? style;

  const OnSurfaceText(this.text,{super.key,  this.style});
  
  @override
  Widget build(BuildContext context) {
    return Text(text,style: style ?? const TextStyle(color: AppThemes.mainColor));
  }

}