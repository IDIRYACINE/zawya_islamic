

import { mutation } from "./_generated/server";
import { v } from "convex/values";
import { IsTeacherMutationCtx } from "./middleware/auth";
import { Doc } from "./_generated/dataModel";



export const markAttendance = mutation({
    args: {
        evaluationId: v.id("studentEvalutations"),
    },
    handler: async (ctx, args) => {

        const isTeacher = await IsTeacherMutationCtx(ctx.auth, ctx.db);
        if (!isTeacher.teacher) return


        const oldAttendance = await ctx.db.get(args.evaluationId);

        if (!oldAttendance) return

        const attendanceId = await ctx.db.patch(args.evaluationId, {
            presence: oldAttendance.presence + 1,
        });

        return {
            attendanceId
        }
    },
})

export const markAbsence = mutation({
    args: {
        evaluationId: v.id("studentEvalutations"),
    },
    handler: async (ctx, args) => {

        const isTeacher = await IsTeacherMutationCtx(ctx.auth, ctx.db);
        if (!isTeacher.teacher) return

        const oldAttendance = await ctx.db.get(args.evaluationId);

        if (!oldAttendance) return

        const attendanceId = await ctx.db.patch(args.evaluationId, {
            presence: oldAttendance.absence + 1,
        });

        return {
            attendanceId
        }

    }
})

export const updateSuratAyat = mutation({
    args: {
        evaluationId: v.id("studentEvalutations"),
        surat: v.string(),
        ayat: v.string(),
    },
    handler: async (ctx, args) => {

        const isTeacher = await IsTeacherMutationCtx(ctx.auth, ctx.db);
        if (!isTeacher.teacher) return

        const attendanceId = await ctx.db.patch(args.evaluationId, {
            surat: args.surat,
            ayat: args.ayat,
        });

        return {
            attendanceId
        }

    }
})


export const markGroupAttendance = mutation({
    args: {
        schooldId: v.id("schools"),
        groupAttendence: v.array(v.object({
            attendenceId: v.id("studentEvalutations"),
            present: v.boolean()
        }))
    },

    handler: async (ctx, args) => {

        const isTeacher = await IsTeacherMutationCtx(ctx.auth, ctx.db);
        if (!isTeacher.teacher) return

        let totalPresence = 0;
        let totalAbsence = 0;

        for (const attendance of args.groupAttendence) {
            const oldAttendance = await ctx.db.get(attendance.attendenceId);

            if (!oldAttendance) return

            const patchedData: Partial<Doc<"studentEvalutations">> = {}

            if (attendance.present) {
                patchedData["presence"] = oldAttendance.presence + 1
                totalPresence += 1
            } else {
                patchedData["absence"] = oldAttendance.absence + 1
                totalAbsence += 1
            }

            await ctx.db.patch(attendance.attendenceId, patchedData);

        }

        const schoolStats = await ctx.db.query("schoolStatistics")
            .withIndex("by_schoolId_month", (q) => q.eq("schoolId", args.schooldId).eq("month", new Date().getMonth())).first();

        if (!schoolStats) return

        await ctx.db.patch(schoolStats._id, {
            monthAbsence: schoolStats.monthAbsence + totalAbsence,
            monthPresence: schoolStats.monthPresence + totalPresence,
        })

    }
})