
import 'package:zawya_islamic/core/ports/auth_service_port.dart';

class UserService implements AuthServicePort{
  @override
  Future<AuthResponse> login({required String identifier, required String password}) {
    // TODO: implement login
    throw UnimplementedError();
  }
  
}