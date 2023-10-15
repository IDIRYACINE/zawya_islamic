import { mutation, query } from "./_generated/server";
import { v } from "convex/values";
import { IsAdminMutationCtx, IsAdminQueryCtx } from "./middleware/auth";



export const addTeacher = mutation({
    args: {
        name: v.string(),
        schoolId: v.id("schools"),
        identificationToken: v.string(),
    },
    handler: async (ctx, args) => {

        const isAdmin = IsAdminMutationCtx(ctx.auth, ctx.db);
        if (!isAdmin) return

        const teacherId = await ctx.db.insert("teachers", {
            name: args.name,
            schoolId: args.schoolId,
            identificationToken: args.identificationToken,
        });

        return {
            teacherId
        }
    },
})

export const updateTeacher = mutation({
    args: {
        teacherId: v.id("teachers"),
        name: v.string(),
    },
    handler: async (ctx, args) => {

        const isAdmin = IsAdminMutationCtx(ctx.auth, ctx.db);

        if (!isAdmin) return

        await ctx.db.patch(args.teacherId, {
            name: args.name,
        });

        return {
            success: true,
        }
    },
})

export const deleteTeacher = mutation({
    args: {
        teacherId: v.id("teachers"),
    },
    handler: async (ctx, args) => {

        const isAdmin = IsAdminMutationCtx(ctx.auth, ctx.db);

        if (!isAdmin) return

        await ctx.db.delete(args.teacherId);

        return {
            success: true,
        }
    },
})

export const getTeachers = query({
    args: {
        schoolId: v.id("schools"),
    },
    handler: async (ctx, args) => {

        const isAdmin = IsAdminQueryCtx(ctx.auth, ctx.db);
        if (!isAdmin) return

        const teachers = await ctx.db.query("teachers").withIndex("by_schoolId", (q) => q.eq("schoolId", args.schoolId)).collect();

        return {
            teachers
        }
    },
});