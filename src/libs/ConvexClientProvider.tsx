import { ReactNode, useEffect } from "react";
import {  useAuth } from "@clerk/clerk-expo";
import { ConvexReactClient } from "convex/react";
import { ConvexProviderWithClerk } from "convex/react-clerk";


const convex = new ConvexReactClient(process.env.CONVEX_URL!);

function ClerkConvexAdapter() {
    const { getToken, isSignedIn } = useAuth();

    useEffect(() => {
        if (isSignedIn) {
            convex.setAuth(async () =>
                getToken({ template: "convex", skipCache: true })
            );
        } else {
            convex.clearAuth();
        }
    }, [getToken, isSignedIn]);
    return null;
}

export default function ConvexClientProvider({
    children,
}: {
    children: ReactNode;
}) {


    return (
        <ConvexProviderWithClerk client={convex} useAuth={useAuth}>
            <ClerkConvexAdapter />
            {children}

        </ConvexProviderWithClerk>
    );
}