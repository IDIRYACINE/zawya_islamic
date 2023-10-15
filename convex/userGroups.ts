import { mutation, query } from "./_generated/server";
import { v } from "convex/values";
import { IsAdminMutationCtx, IsAdminQueryCtx } from "./middleware/auth";



export const assignStudentToGroup = mutation({
    args: {
        studentId: v.id("students"),
        groupId: v.id("groups"),
    },
    handler: async (ctx, args) => {

        const isAdmin = IsAdminMutationCtx(ctx.auth, ctx.db);
        if (!isAdmin) return

        await ctx.db.insert("studentGroups", {
            groupId: args.groupId,
            studentId: args.studentId,
        });

        return {
            success: true,
        }
    },
})

export const removeStudentFromGroup = mutation({
    args: {
        assignementId: v.id("studentGroups"),
    },
    handler: async (ctx, args) => {

        const isAdmin = IsAdminMutationCtx(ctx.auth, ctx.db);
        if (!isAdmin) return

        await ctx.db.delete(args.assignementId);

        return {
            success: true,
        }
    },
})

export const assignTeacherToGroup = mutation({
    args: {
        teacherId: v.id("teachers"),
        groupId: v.id("groups"),
    },
    handler: async (ctx, args) => {

        const isAdmin = IsAdminMutationCtx(ctx.auth, ctx.db);
        if (!isAdmin) return

        await ctx.db.insert("teacherGroups", {
            groupId: args.groupId,
            teacherId: args.teacherId,
        });

        return {
            success: true,
        }
    },
})

export const removeTeacherFromGroup = mutation({
    args: {
        assignementId: v.id("teacherGroups"),
    },
    handler: async (ctx, args) => {

        const isAdmin = IsAdminMutationCtx(ctx.auth, ctx.db);
        if (!isAdmin) return

        await ctx.db.delete(args.assignementId);

        return {
            success: true,
        }
    },
})


