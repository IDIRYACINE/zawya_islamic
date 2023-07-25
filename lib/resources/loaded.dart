

import 'package:flutter/material.dart';
import 'package:vector_graphics/vector_graphics.dart';

import 'resources.dart';

abstract class LoadedAppResources{
  static late  AssetBytesLoader backgroundImage;
  static late AssetBytesLoader logoBlack;
  static late AssetImage backgroundImageAsset;

  static bool loaded = false;


  static Future<void> loadResource() async{
    if(loaded){
      return;
    }
    
    backgroundImage =  const AssetBytesLoader(AppResources.backgroundPatterns);
    logoBlack = const AssetBytesLoader(AppResources.logoBlack);
    backgroundImageAsset = const AssetImage(AppResources.backgroundPatterns);

    loaded = true;

  }
}