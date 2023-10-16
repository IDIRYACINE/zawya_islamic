import 'dart:io';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_graphics/vector_graphics.dart';
import 'package:zawya_islamic/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:zawya_islamic/resources/themes.dart';

class FaultToleratedImage extends StatelessWidget {
  const FaultToleratedImage(
      {Key? key, required this.imageUrl, this.width, this.height})
      : super(key: key);

  final String imageUrl;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Image.file(
      File(imageUrl),
      width: width,
      height: height,
      fit: BoxFit.fill,
      errorBuilder: (context, error, stack) =>
          Image.asset(AppResources.noPreviewImage),
    );
  }
}

class AccentIcon extends StatelessWidget {
  const AccentIcon({super.key, this.iconDataBytes, this.iconDataAsset})
      : assert((iconDataAsset == null ) || (iconDataBytes == null),
            "Must provide iconDataBytes or iconDataAsset");

  final AssetBytesLoader? iconDataBytes;
  final AssetImage? iconDataAsset;

  @override
  Widget build(BuildContext context) {
    final icon = iconDataBytes != null
        ? SvgPicture(
            iconDataBytes!,
            fit: BoxFit.contain,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          )
        : Image(
            image: iconDataAsset!,
          );

    return SizedBox(
      width: 100,
      child: ColoredBox(
        color: AppThemes.accentColor,
        child: Center(child: icon),
      ),
    );
  }
}
