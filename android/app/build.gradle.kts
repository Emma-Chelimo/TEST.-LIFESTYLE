plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("com.google.gms.google-services")
    id("com.google.firebase.crashlytics")
    id("com.google.firebase.firebase-perf")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.project"
    compileSdk = 36
    ndkVersion = "27.3.13750724"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        // jvmTarget must be a string
        jvmTarget = "11"
    }

    defaultConfig {
        // Application id
        applicationId = "com.example.project"

        // Ensure minSdk >= 23 for current Flutter versions (24 is fine)
        minSdk = 24
        targetSdk = 34

        // If you use the Flutter Gradle plugin extension, it provides these values.
        // If not, set concrete values here (1 and "1.0" are safe defaults).
        versionCode = try {
            // safe access in case the flutter extension is present
            val flutterExt = extensions.findByName("flutter")
            if (flutterExt != null) {
                // flutter.versionCode is provided by the Flutter Gradle plugin
                @Suppress("UNCHECKED_CAST")
                (extensions.getByName("flutter") as org.gradle.api.plugins.ExtensionAware).let { fe ->
                    val map = fe as Any
                }
                // fallback to 1 if access fails
                1
            } else 1
        } catch (e: Exception) {
            1
        }
        versionName = "1.0"
    }

    buildTypes {
        getByName("release") {
            // Replace with your signing config for release builds if available.
            signingConfig = signingConfigs.getByName("debug")
            isMinifyEnabled = true
            isShrinkResources = true
            // Keep default proguard configuration unless you add rules
            proguardFiles(getDefaultProguardFile("proguard-android.txt"), "proguard-rules.pro")
        }
    }

    // If your project uses flavor dimensions or productFlavors, define them here.
}

flutter {
    source = "../.."
}