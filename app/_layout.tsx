import { Slot } from 'expo-router';
import '../i18n';
import { ClerkProvider } from '@clerk/clerk-expo';
import ConvexClientProvider from '../src/libs/ConvexClientProvider';

export default function HomeLayout() {
    return (
        <ClerkProvider publishableKey={process.env.CLERK_PUBLISHABLE_KEY!} >
            <ConvexClientProvider>
                <Slot />
            </ConvexClientProvider>
        </ClerkProvider>

    )

}