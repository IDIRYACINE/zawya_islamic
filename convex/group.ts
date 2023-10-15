import { mutation, query } from "./_generated/server";
import { v } from "convex/values";
import { IsAdminMutationCtx } from "./middleware/auth";

export const addGroup = mutation({
    args: {
        name: v.string(),
        schoolId: v.id("schools"),
    },
    handler: async (ctx, args) => {

        const isAdmin = IsAdminMutationCtx(ctx.auth, ctx.db);
        if (!isAdmin) return

        const groupId = await ctx.db.insert("groups", {
            name: args.name,
            schoolId: args.schoolId,
        });

        return {
            groupId
        }
    },
})

export const updateGroup = mutation({
    args: {
        groupId: v.id("groups"),
        name: v.string(),
    },
    handler: async (ctx, args) => {

        const isAdmin = IsAdminMutationCtx(ctx.auth, ctx.db);

        if (!isAdmin) return

        await ctx.db.patch(args.groupId, {
            name: args.name,
        });

        return {
            success: true,
        }
    },
})


export const deleteGroup = mutation({
    args: {
        groupId: v.id("groups"),
    },
    handler: async (ctx, args) => {

        const isAdmin = IsAdminMutationCtx(ctx.auth, ctx.db);

        if (!isAdmin) return

        await ctx.db.delete(args.groupId);

        return {
            success: true,
        }
    },
})