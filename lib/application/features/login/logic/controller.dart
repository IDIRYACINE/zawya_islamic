import 'package:flutter/material.dart';
import 'package:zawya_islamic/application/navigation/navigation_service.dart';

class LoginController {
  static final key = GlobalKey<FormState>();

  String identifier = "";
  String password = "";

  void login(BuildContext context) {
    if (key.currentState!.validate()) {
      NavigationService.pushNamedReplacement(Routes.adminAppRoute);
    }
  }
}
