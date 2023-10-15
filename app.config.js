module.exports = {
    name: 'Zawya',
    version: '1.0.0',
    android : {
      package : "com.idir.zawya"
    },
    ios: {
      bundleIdentifier: "com.idir.zawya"
    },
    extra: {
      clerkPublishableKey: process.env.CLERK_PUBLISHABLE_KEY,
    },
    "scheme": "myapp",

    "web": {
      "bundler": "metro"
    },
    plugins: [
      "expo-localization",
      "expo-router"
    ]
};