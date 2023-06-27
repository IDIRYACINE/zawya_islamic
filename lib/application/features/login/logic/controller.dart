

import 'package:flutter/material.dart';

class LoginController{


  static final key = GlobalKey<FormState>();

  String identifier = "";
  String password = "";

  void login(BuildContext context){
    if(key.currentState!.validate()){
      
    }
  }

}