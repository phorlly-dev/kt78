import java.util.Properties
import java.io.FileInputStream

// Load key.properties
val keyProperties = Properties()
val keyPropertiesFile = rootProject.file("key.properties")
if (keyPropertiesFile.exists()) {
    keyProperties.load(FileInputStream(keyPropertiesFile))
}

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")

    id("com.google.gms.google-services")
}

android {
    namespace = "com.indkt78.kt78"
    compileSdk = flutter.compileSdkVersion
    // ndkVersion = flutter.ndkVersion
     ndkVersion = "27.0.12077973"

    compileOptions {
             // Flag to enable support for the new language APIs
        isCoreLibraryDesugaringEnabled = true

        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.indkt78.kt78"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        // minSdk = flutter.minSdkVersion
        minSdk = 23
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName

         multiDexEnabled = true
    }

     signingConfigs {
        create("release") {
            storeFile = file(keyProperties["storeFile"] as String)
            storePassword = keyProperties["storePassword"] as String
            keyAlias = keyProperties["keyAlias"] as String
            keyPassword = keyProperties["keyPassword"] as String
        }
    }

    buildTypes {
        // release {
        //     // TODO: Add your own signing config for the release build.
        //     // Signing with the debug keys for now, so `flutter run --release` works.
        //     signingConfig = signingConfigs.getByName("debug")
        // }

        getByName("release") {
        isMinifyEnabled = true // Enable code shrinking
        isShrinkResources = true // Enable resource shrinking
        signingConfig = signingConfigs.getByName("release")
        proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
        }
    }
}

 dependencies {
  // Import the Firebase BoM
  implementation(platform("com.google.firebase:firebase-bom:33.13.0"))

  // TODO: Add the dependencies for Firebase products you want to use
  // When using the BoM, don't specify versions in Firebase dependencies
  implementation("com.google.firebase:firebase-analytics")

//   implementation("androidx.core:core:1.12.0") // ensure this is updated
  coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")

  //onesignal
  implementation("com.onesignal:OneSignal:[5.1.6, 5.1.99]")
}

flutter {
    source = "../.."
}
