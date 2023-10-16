import { Link } from 'expo-router';
import { StatusBar } from 'expo-status-bar';
import { ImageBackground, StyleSheet, Image, View } from 'react-native';


export default function App() {

    const bgImage = require('../assets/images/background_pattern.png');
    const logoImage = require('../assets/images/logo_black.png');



    return (
        <View style={styles.container}>
            <ImageBackground source={bgImage} resizeMode="cover" style={styles.backgroundImage}>
                <Image source={logoImage} resizeMode="stretch" style={styles.logoSmall} />
                <Link href={'/teacher'} style={styles.text}>Teacher</Link>
            </ImageBackground>

            <StatusBar style="auto" />
        </View>

    );
}

const styles = StyleSheet.create({
    backgroundImage: {
        flex: 1,
        resizeMode: "cover",
        justifyContent: "center",
        alignItems: 'center',
        height: '100%',
        width: '100%',
    },
    container: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
    },
    logoSmall: {
        width: "50%",
        height: "50%",
    },
    text: {
        color: 'white',
        fontSize: 42,
        lineHeight: 84,
        fontWeight: 'bold',
        textAlign: 'center',
        backgroundColor: '#000000c0',
    },
});
