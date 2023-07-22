

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:zawya_islamic/core/entities/quran.dart';

List<Surat> suwarList = [];



Future<void> loadSuwarFromAssets() async{
    String jsonString = await rootBundle.loadString('assets/data/suwar.json');
  final List<dynamic> rawData = json.decode(jsonString);

  suwarList = rawData.map((e) => Surat.fromMap(e)).toList();
}