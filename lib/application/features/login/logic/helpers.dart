

import 'package:shared_preferences/shared_preferences.dart';

enum CredentialsCacheKeys { identifier, password }


class LoginCredentials {
  final String identifier;
  final String password;

  LoginCredentials({required this.identifier, required this.password});
}

Future<void> cacheLoginCredentials(String identifier,String pasword) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  prefs.setString(CredentialsCacheKeys.identifier.name, identifier);
  prefs.setString(CredentialsCacheKeys.password.name, pasword);

}


Future<LoginCredentials?> loginFromCache() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final String? identifier = prefs.getString(CredentialsCacheKeys.identifier.name);
  final String? password = prefs.getString(CredentialsCacheKeys.password.name);

  if (identifier != null && password != null) {
    return LoginCredentials(identifier: identifier, password: password);
  }

  return null ;

}