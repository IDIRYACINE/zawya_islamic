

import 'package:zawya_islamic/core/ports/auth_service_port.dart';
import 'package:zawya_islamic/core/ports/groups_service_port.dart';
import 'package:zawya_islamic/core/ports/school_service_port.dart';
import 'package:zawya_islamic/core/ports/services_provider_port.dart';
import 'package:zawya_islamic/core/ports/student_service_port.dart';
import 'package:zawya_islamic/core/ports/teacher_service_port.dart';
import 'package:zawya_islamic/infrastructure/helpers/firebase/export.dart';

import 'group_service.dart';
import 'school_service.dart';
import 'student_service.dart';
import 'teacher_service.dart';

class ServicesProvider implements ServiceProviderPort{

  static final ServicesProvider? _instance;
  ServicesProvider._internal();

  factory ServicesProvider.instance() {
    if (_instance == null) {
      return ServicesProvider._internal();
    }
    return _instance!;
  }

  Future<void> init() async{
    final app =  MyFirebaseApp();
    await app.init();

    final firestoreService = FirestoreService(app.firestore);

    groupService = GroupService(firestoreService);
    schoolService = SchoolService(firestoreService);
    studentService = StudentService(firestoreService);
    teacherService = TeacherService(firestoreService);
    
  }


  @override
  late AuthServicePort authService ;

  @override
  late GroupServicePort  groupService ;


  @override
  late SchoolServicePort  schoolService ;

  @override
  late StudentServicePort  studentService ;

  @override
  late TeacherServicePort  teacherService ;

}