enum RoutesEnum {
  login,
}

abstract class Routes {
  static const loginRoute = "/login";
  static const adminAppRoute = "/admin";
  static const teacherAppRoute = "/teacher";
  static const studentAppRoute = "/student";
  static const anonymousAppRoute = "/anonymous";
  static const adminDashboardRoute = "/admin/dashbaord";
  static const teacherDashboardRoute = "/teacher/dashbaord";
  static const groupStudentsScheduleRoute = "/group/studentsOrschedule";
  static const searchStudentRoute = "/search/student";
  static const searchGroupRoute = "/search/group";

  static const splashRoute = "/splash";

  static const String settingsRoute = "/settings";

  static const String studentGroupStatistique = "/statistiques/group";

  static const String statistiquesRoute = "/statistiques";

  static const String groupScheduleRoute = "/group/schedule";

  static const String groupsRoute = "/groups";
}
