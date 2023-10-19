enum RpcFunctions { updateStudentsPresence }

extension RpcFunctionsExtension on RpcFunctions {
  String get functionName {
    switch (this) {
      case RpcFunctions.updateStudentsPresence:
        return "update_student_presence";

      default:
        return "s";
    }
  }
}

enum GroupsTable { groupId, groupName, schoolId }

enum SchoolTable { schoolId, schoolName }

enum UserGroupsTable { userId, groupId }

enum TeacherTable { userId, teacherName, email, password }

enum SessionTable {
  sessionId,
  date,
}

enum PresenceTable { presenceId, studentId, presence, sessionId }

enum EvaluationTable { studentId, groupId, surat, ayat, schoolId }

enum UserTable { userId, userName, userRole, birthDate, schoolId }

enum StudentEvaluationAndPresenceTable {
  userId,
  presence,
  absence,
  evaluationAyat,
  evaluationSurat
}

enum DaysTable { dayId, dayName }

enum GroupsScheduleTable { groupId, dayId, startMinuteId, endMinuteId, room }
