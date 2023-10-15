

import { mutation } from "./_generated/server";
import { v } from "convex/values";
import { IsAdminMutationCtx } from "./middleware/auth";


export const addScheduleEntry = mutation({
    args: {
        groupId: v.id("groups"),
        dayId: v.id("days"),
        startTime: v.string(),
        endTime: v.string(),

    },
    handler: async (ctx, args) => {

        const isAdmin = IsAdminMutationCtx(ctx.auth, ctx.db);
        if (!isAdmin) return

        await ctx.db.insert("groupSchedules", {
            groupId: args.groupId,
            dayId: args.dayId,
            start: args.startTime,
            end: args.endTime,
        });

        return {
            success: true,
        }
    },
})


export const removeScheduleEntry = mutation({
    args: {
        scheduleEntryId: v.id("groupSchedules"),
    },
    handler: async (ctx, args) => {

        const isAdmin = IsAdminMutationCtx(ctx.auth, ctx.db);
        if (!isAdmin) return

        await ctx.db.delete(args.scheduleEntryId);

        return {
            success: true,
        }
    },
})