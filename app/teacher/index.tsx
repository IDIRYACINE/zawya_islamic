import { SignedIn, SignedOut } from "@clerk/clerk-expo";
import { View, Text } from "react-native";


export default function Teacher() {
    return (
        <View>
            <SignedIn>
                Welcome
            </SignedIn>
            <SignedOut>
                <Text>Teacher</Text>

            </SignedOut>
        </View>
    )
}