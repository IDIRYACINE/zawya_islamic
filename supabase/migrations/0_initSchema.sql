create table if not exists "userRoles" (
  "roleId" bigint generated by default as identity not null,
  "roleName" text null,
  constraint userRoles_pkey primary key ("roleId")
) tablespace pg_default;

create table if not exists schools (
  "schoolName" text null,
  "schoolId" uuid not null primary key
) tablespace pg_default;

create table if not exists "users" (
  "userId" uuid not null,
  "userName" text null,
  "userRole" bigint null,
  "birthDate" date null,
  "schoolId" uuid null,
  constraint users_pkey primary key ("userId"),
  constraint users_userRole_fkey foreign key ("userRole") references "userRoles" ("roleId"),
  constraint users_schoolId_fkey foreign key ("schoolId") references "schools" ("schoolId")
) tablespace pg_default;

create table if not exists groups (
  "groupName" text null,
  "groupId" uuid not null,
  "schoolId" uuid null,
  constraint groups_pkey primary key ("groupId")
) tablespace pg_default;

create table if not exists "userGroups" (
  "userId" uuid not null,
  "groupId" uuid null,
  constraint userGroups_pkey primary key ("userId", "groupId"),
  constraint userGroups_groupId_fkey foreign key ("groupId") references groups ("groupId") on delete cascade,
  constraint userGroups_userId_fkey foreign key ("userId") references users ("userId") on delete cascade
) tablespace pg_default;

create table if not exists "studentEvaluations" (
  "userId" uuid not null,
  "evaluationSurat" Text default '',
  "evaluationAyat" Integer default 0,
  "presence" Integer default 0,
  "absence" Integer default 0,
  constraint studentEvaluations_pkey primary key ("userId"),
  constraint studentEvaluations_userId_fkey foreign key ("userId") references users ("userId") on delete cascade
) tablespace pg_default;

create table if not exists "days" (
  "dayId" SMALLINT not null,
  "dayName" Text not null,
  constraint days_pkey primary key ("dayId")
) tablespace pg_default;

create table if not exists "groupSchedules" (
  "dayId" SMALLINT not null,
  "groupId" uuid not null,
  "startMinuteId" SMALLINT not null,
  "endMinuteId" SMALLINT not null,
  "room" Text not null,
  constraint groupSchedules_pkey primary key ("dayId", "groupId", "startMinuteId"),
  constraint groupSchedules_groupId_fkey foreign key ("groupId") references groups ("groupId") on delete cascade
) tablespace pg_default;

create
or replace view "groupStudents" as
select
  users.*,
  "userGroups"."groupId"
from
  "userGroups"
  inner join users on "userGroups"."userId" = users."userId"
where
  users."userRole" = 2;

create
or replace view "teacherGroups" as
select
  groups.*,
  users."userId"
from
  "userGroups"
  inner join users on "userGroups"."userId" = users."userId"
  inner join groups on "userGroups"."groupId" = groups."groupId"
where
  users."userRole" = 1;

create
or replace view "schoolStudents" as
select
  users.*
from
  "users"
where
  users."userRole" = 2;

create
or replace view "schoolTeachers" as
select
  users.*
from
  "users"
where
  users."userRole" = 1;

create
or replace view "groupStudentEvaluations" as
SELECT
  se.*,
  u."userName",
  u."birthDate",
  u."schoolId",
  ug."groupId"
FROM
  "studentEvaluations" se
  JOIN "users" u ON se."userId" = u."userId"
  JOIN "userGroups" ug ON u."userId" = ug."userId"
WHERE
  u."userRole" = 2;

create
or replace view "groupScheduleOrderd" as
select
  "groupSchedules".*
from
  "groupSchedules"
ORDER BY
  "groupSchedules"."dayId",
  "groupSchedules"."startMinuteId";

CREATE
OR REPLACE FUNCTION create_student_evaluation() RETURNS TRIGGER AS $ $ BEGIN IF NEW."userRole" = 2 THEN
INSERT INTO
  "studentEvaluations" ("userId")
VALUES
  (NEW."userId");

END IF;

RETURN NEW;

END;

$ $ LANGUAGE plpgsql;

CREATE
OR REPLACE FUNCTION clean_after_teacher_delete() RETURNS TRIGGER AS $ $ BEGIN IF NEW."userRole" = 0
or NEW."userRole" = 1 THEN
DELETE FROM
  "auth.users"
WHERE
  "id" = NEW."userId";

END IF;

RETURN NEW;

END;

$ $ LANGUAGE plpgsql;

create
or replace view "studentGroups" as
select
  groups.*,
  users."userId"
from
  "userGroups"
  inner join users on "userGroups"."userId" = users."userId"
  inner join groups on "userGroups"."groupId" = groups."groupId"
where
  users."userRole" = 2;

create
or replace view "monthlyPresence" as
select
  sum("presence") as "presence",
  sum("absence") as "absence",
  sum("chaotic") as "chaotic",
  sum("discipline") as "discipline",
  "schoolId"
FROM
  "groupAttendanceStatistics" 
Group by
  "schoolId";

CREATE MATERIALIZED VIEW "groupAttendanceStatistics" AS
SELECT
  g."groupId",
  g."groupName",
  g."schoolId",
  COUNT(
    CASE
      WHEN se.presence = 0 THEN 1
    END
  ) AS absence,
  COUNT(
    CASE
      WHEN se.presence > 0 THEN 1
    END
  ) AS presence,
  COUNT(
    CASE
      WHEN se.presence > se.absence THEN 1
    END
  ) AS discipline,
  COUNT(
    CASE
      WHEN se.presence <= se.absence THEN 1
    END
  ) AS chaotic
FROM
  "studentEvaluations" se
  JOIN "userGroups" ug ON se."userId" = ug."userId"
  JOIN "groups" g ON ug."groupId" = g."groupId"
GROUP BY
  g."groupId";