import { defineSchema, defineTable } from "convex/server";
import { v } from "convex/values";


const schools = defineTable({
    name: v.string(),
})

const users = defineTable({
    identificationToken: v.string(),
    name: v.string(),
}).index("by_identificationToken", ["identificationToken"])

const students = defineTable({
    birthday: v.string(),
    name: v.string(),
    schooldId: v.id("schools"),
})

const schoolStatistics = defineTable({
    schoolId: v.id("schools"),
    monthPresence: v.number(),
    monthAbsence: v.number(),
    month: v.number(),
}).index("by_schoolId_month", ["schoolId", "month"])

const teachers = defineTable({
    schoolId: v.id("schools"),
    identificationToken: v.string(),
    name: v.string(),
}).index("by_identificationToken", ["identificationToken"])
    .index("by_schoolId", ["schoolId"])

const groups = defineTable({
    name: v.string(),
    schoolId: v.id("schools"),
})

const studentGroups = defineTable({
    studentId: v.id("students"),
    groupId: v.id("groups"),
})

const teacherGroups = defineTable({
    teacherId: v.id("teachers"),
    groupId: v.id("groups"),
})

const studentEvalutations = defineTable({
    studentId: v.id("students"),
    presence: v.number(),
    absence: v.number(),
    surat: v.string(),
    ayat: v.string(),
}).index("by_studentId", ["studentId"])

const days = defineTable({
    name: v.string(),
})

const groupSchedules = defineTable({
    groupId: v.id("groups"),
    dayId: v.id("days"),
    start: v.string(),
    end: v.string(),
})

export default defineSchema({
    days,
    groupSchedules,
    teachers,
    schools,
    users,
    students,
    groups,
    teacherGroups,
    studentGroups,
    studentEvalutations,
    schoolStatistics
});