import { Auth, GenericDatabaseReader, GenericDatabaseWriter } from "convex/server";
import { DataModel } from "../_generated/dataModel";

export const IsAdminMutationCtx = async (auth: Auth, db: GenericDatabaseWriter<DataModel>) => {

    const tokenId = (await auth.getUserIdentity())?.tokenIdentifier;
    if (!tokenId) {
        return false;
    }

    const user = await db.query("users").withIndex("by_identificationToken",
        (q) => q.eq("identificationToken", tokenId)).first();

    if (!user) {
        return false;
    }


    return true;
}

export const IsAdminQueryCtx = async (auth: Auth, db: GenericDatabaseReader<DataModel>) => {
    const tokenId = (await auth.getUserIdentity())?.tokenIdentifier;
    if (!tokenId) {
        return false;
    }

    const user = await db.query("users").withIndex("by_identificationToken",
        (q) => q.eq("identificationToken", tokenId)).first();

    if (!user) {
        return false;
    }


    return true;
}

export const IsTeacherMutationCtx = async (auth: Auth, db: GenericDatabaseWriter<DataModel>) => {

    const tokenId = (await auth.getUserIdentity())?.tokenIdentifier;
    if (!tokenId) {
        return { teacher: false, tokenId: tokenId };
    }

    const user = await db.query("teachers").withIndex("by_identificationToken",
        (q) => q.eq("identificationToken", tokenId)).first();

    if (!user) {
        return { teacher: false, tokenId: tokenId };
    }


    return { teacher: true, tokenId: tokenId };

}