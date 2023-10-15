import { mutation, query } from "./_generated/server";
import { v } from "convex/values";
import { IsAdminMutationCtx } from "./middleware/auth";



export const getSchools = query({
    args: {},
    handler: async (ctx, args) => {
        const schools = await ctx.db.query("schools").collect();

        return {
            schools
        }
    },
});


export const addSchool = mutation({
    args: {
        name: v.string(),
    },
    handler: async (ctx, args) => {
        const schoolId = await ctx.db.insert("schools", {
            name: args.name,
        });

        for (let i = 1; i < 13; i++) {
            await ctx.db.insert("schoolStatistics", {
                schoolId,
                month: i,
                monthAbsence: 0,
                monthPresence: 0,
            });
        }

        return {
            schoolId
        }
    },
})


export const updateSchool = mutation({
    args: {
        schoolId: v.id("schools"),
        name: v.string(),
    },
    handler: async (ctx, args) => {

        const isAdmin = IsAdminMutationCtx(ctx.auth, ctx.db);

        if (!isAdmin) return

        await ctx.db.patch(args.schoolId, {
            name: args.name,
        });

        return {
            success: true,
        }
    },
})


export const deleteSchool = mutation({
    args: {
        schoolId: v.id("schools"),
    },
    handler: async (ctx, args) => {

        const isAdmin = IsAdminMutationCtx(ctx.auth, ctx.db);

        if (!isAdmin) return

        await ctx.db.delete(args.schoolId);

        return {
            success: true,
        }
    },
})