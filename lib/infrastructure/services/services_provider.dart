

import 'package:zawya_islamic/core/ports/auth_service_port.dart';
import 'package:zawya_islamic/core/ports/groups_service_port.dart';
import 'package:zawya_islamic/core/ports/school_service_port.dart';
import 'package:zawya_islamic/core/ports/services_provider_port.dart';
import 'package:zawya_islamic/core/ports/student_service_port.dart';
import 'package:zawya_islamic/core/ports/teacher_service_port.dart';

class ServicesProvider implements ServiceProviderPort{
  @override
  // TODO: implement authService
  AuthServicePort get authService => throw UnimplementedError();

  @override
  // TODO: implement groupService
  GroupServicePort get groupService => throw UnimplementedError();

  @override
  // TODO: implement instance
  ServiceProviderPort get instance => throw UnimplementedError();

  @override
  // TODO: implement schoolService
  SchoolServicePort get schoolService => throw UnimplementedError();

  @override
  // TODO: implement studentService
  StudentServicePort get studentService => throw UnimplementedError();

  @override
  // TODO: implement teacherService
  TeacherServicePort get teacherService => throw UnimplementedError();

}