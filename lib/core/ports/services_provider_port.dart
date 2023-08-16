

import 'package:zawya_islamic/core/ports/student_service_port.dart';
import 'package:zawya_islamic/infrastructure/ports/logger_port.dart';

import 'auth_service_port.dart';
import 'groups_service_port.dart';
import 'school_service_port.dart';
import 'teacher_service_port.dart';

abstract class ServiceProviderPort{

  AuthServicePort get authService;

  StudentServicePort get studentService;

  SchoolServicePort get schoolService;

  GroupServicePort get groupService;

  TeacherServicePort get teacherService;

  LoggerServicePort get loggerService;
}