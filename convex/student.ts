import { mutation } from "./_generated/server";
import { v } from "convex/values";
import { IsAdminMutationCtx } from "./middleware/auth";

export const addStudent = mutation({
    args: {
        name: v.string(),
        schoolId: v.id("schools"),
        birthday: v.string(),
    },
    handler: async (ctx, args) => {

        const isAdmin = IsAdminMutationCtx(ctx.auth, ctx.db);
        if (!isAdmin) return

        const studentId = await ctx.db.insert("students", {
            name: args.name,
            birthday: args.birthday,
            schooldId: args.schoolId,
        });

        await ctx.db.insert("studentEvalutations", {
            studentId,
            presence: 0,
            absence: 0,
            surat: "",
            ayat: "",
        });

        return {
            studentId
        }
    },
})

export const updateStudent = mutation({
    args: {
        studentId: v.id("students"),
        name: v.string(),
        birthday: v.string(),
    },
    handler: async (ctx, args) => {

        const isAdmin = IsAdminMutationCtx(ctx.auth, ctx.db);

        if (!isAdmin) return

        await ctx.db.patch(args.studentId, {
            name: args.name,
            birthday: args.birthday,
        });

        return {
            success: true,
        }
    },
})

export const deleteStudent = mutation({
    args: {
        studentId: v.id("students"),
    },
    handler: async (ctx, args) => {

        const isAdmin = IsAdminMutationCtx(ctx.auth, ctx.db);

        if (!isAdmin) return

        await ctx.db.delete(args.studentId);

        const studentEvalutation = await ctx.db.query("studentEvalutations")
            .withIndex("by_studentId", (q) => q.eq("studentId", args.studentId)).first();

        if (studentEvalutation) {
            await ctx.db.delete(studentEvalutation._id);
        }

        return {
            success: true,
        }
    },
})
