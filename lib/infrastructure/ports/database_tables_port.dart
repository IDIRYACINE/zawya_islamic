

enum GroupsTable {
  groupId,
  groupName,
  schoolId
}

enum SchoolTable{
  schoolId,
  schoolName
}


enum UserGroupsTable{
  userId,
  groupId
}

enum TeacherTable{
  teacherId,
  teacherName,
  email,
  password
}


enum SessionTable{
  sessionId,
  date,
}

enum PresenceTable{
  presenceId,
  studentId,
  presence,
  sessionId
}

enum EvaluationTable{
  studentId,
  groupId,
  surat,
  ayat,
}


enum UserTable{
  userId,
  userName,
  userRole,
  birthDate, 
  schoolId

}

enum StudentEvaluationAndPresenceTable{
  userId,
  presence,
  absence,
  evaluationAyat,
  evaluationSurat
}