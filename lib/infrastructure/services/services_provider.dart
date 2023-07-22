import 'package:zawya_islamic/application/teacher_app/evaluation/logic/data.dart';
import 'package:zawya_islamic/core/ports/auth_service_port.dart';
import 'package:zawya_islamic/core/ports/groups_service_port.dart';
import 'package:zawya_islamic/core/ports/school_service_port.dart';
import 'package:zawya_islamic/core/ports/services_provider_port.dart';
import 'package:zawya_islamic/core/ports/student_service_port.dart';
import 'package:zawya_islamic/core/ports/teacher_service_port.dart';
import 'package:zawya_islamic/infrastructure/helpers/firebase/export.dart';
import 'package:zawya_islamic/infrastructure/helpers/firebase/firebase_auth_helper.dart';
import 'package:zawya_islamic/infrastructure/helpers/supabase/supabase_app.dart';
import 'package:zawya_islamic/infrastructure/helpers/supabase/supabase_auth.dart';
import 'package:zawya_islamic/infrastructure/helpers/supabase/supabase_postgress_service.dart';

import 'group_service.dart';
import 'school_service.dart';
import 'student_service.dart';
import 'teacher_service.dart';
import 'user_service.dart';

class ServicesProvider implements ServiceProviderPort {
  static ServicesProvider? _instance;
  ServicesProvider._internal();

  bool _isInit = false;

  factory ServicesProvider.instance() {
    _instance ??= ServicesProvider._internal();
    return _instance!;
  }

  // ignore: unused_element
  Future<void> _initFirebase() async {
    final app = MyFirebaseApp();
    await app.init();

    final firestoreService = FirestoreService(app.firestore);
    final fireauthService = FirebaseAuthHelper(app.firebaseAuth);

    groupService = GroupService(firestoreService);
    schoolService = SchoolService(firestoreService);
    studentService = StudentService(firestoreService);
    teacherService = TeacherService(firestoreService);

    authService =
        UserService(fireauthService, firestoreService, teacherService);
  }


  Future<void> _initSupabase() async {
    final app = SupabaseApp();
    await app.init();

    final databaseServiceHelper = SupabasePostrgessService(app.supabase.client);
    final authServiceHelper = SupabaseAuthHelper (app.supabase.client);

    groupService = GroupService(databaseServiceHelper);
    schoolService = SchoolService(databaseServiceHelper);
    studentService = StudentService(databaseServiceHelper);
    teacherService = TeacherService(databaseServiceHelper);

    authService =
        UserService(authServiceHelper, databaseServiceHelper, teacherService);
  }

  Future<void> init() async {
    if (_isInit) {
      return;
    }

   await _initSupabase();
   await loadSuwarFromAssets();

    _isInit = true;
  }

  @override
  late AuthServicePort authService;

  @override
  late GroupServicePort groupService;

  @override
  late SchoolServicePort schoolService;

  @override
  late StudentServicePort studentService;

  @override
  late TeacherServicePort teacherService;
}
