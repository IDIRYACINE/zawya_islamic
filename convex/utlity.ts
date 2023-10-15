
import { internalMutation } from "./_generated/server";



export const setupDays = internalMutation({
    args: {
    },
    handler: async (ctx, args) => {

        const days = ["السبت", "الاحد", "الاثنين", "الثلاثاء", "الاربعاء", "الخميس", "الجمعة"];

        for (const day of days) {
            await ctx.db.insert("days", {
                name: day,
            });
        }

        return {
            success: true,
        }
    },
})