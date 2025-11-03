plugins {
    id("com.android.application")
}

android {
    namespace = "org.example.busybox"
    compileSdk = 34

    defaultConfig {
        applicationId = "org.example.busybox"
        minSdk = 24
        targetSdk = 34
        versionCode = 1370
        versionName = "1.37.0"
    }

    buildTypes {
        release {
            isMinifyEnabled = false
        }
    }
}

dependencies {
    // No external dependencies required
}
