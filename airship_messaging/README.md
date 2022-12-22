# airship_messaging

Airship messaging demo

## Usage

1. Add the airship_flutter dependency to your package's pubspec.yaml file:

```yaml
dependencies:
  airship_flutter: ^6.2.0
```

2. Install your flutter package dependencies by running the following in the command line at your project's root directory:

```bash
flutter pub get
```

3. Import airship into your project:

```dart
import 'package:airship_flutter/airship_flutter.dart';
```

### Android setup

Follow the steps outlined in [Android Getting Started](https://docs.airship.com/platform/android/getting-started/).

1. Download the Firebase google-services.json file and place it inside android/app.

2. Apply the `com.google.gms.google-services` plugin to the android/app.

3. Create a new `airshipconfig.properties` file with your application’s settings and
place it inside the `android/app/src/main/assets` directory.

4. Optional. In order to be notified of messages that are sent to the device while the app is in the background, define a `BackgroundMessageHandler` as a top-level function in your app's main.dart file:

```dart
Future<void> backgroundMessageHandler(
    Map<String, dynamic> payload,
    Notification? notification) async { 
  // Handle the message
  print("Received background message: $payload, $notification");
}

void main() {
  Airship.setBackgroundMessageHandler(backgroundMessageHandler);
  runApp(MyApp());
}
```

The handler is executed in a separate background isolate outside the application's main isolate,
so it is not possible to interact with the application UI or update application state from the handler.
Care should be taken to ensure the handler logic completes as soon as possible in order to avoid 
ANRs (Application Not Responding), which may trigger the OS to automatically terminate the process.

### iOS Setup

Follow the steps outlined in [iOS Getting Started](https://docs.airship.com/platform/ios/getting-started/)

#### Apple steps

You need from https://developer.apple.com/:

- Team ID (2MJB7W47PE)
- Bundle ID (com.atanashristov.airshipMessagingStaging)

1. Create AppID at developer.apple.com

Create AppID [here](https://developer.apple.com/account/resources/identifiers/add/bundleId)

Your app needs the following capabilities, so make sure you select this:

- Push Notifications

2. Add key at developer.apple.com

Add new key [here](https://developer.apple.com/account/resources/authkeys/add)

Give it a name (Auth Key with Push Notifications). Note:: Apple allows only two keys with push notifications per team.

Make sure you enable:

- Apple Push Notifications service (APNs)

IMPORTANT: Create the key and download the key file. This is a one time oportunity to doanload the key file.

Note the Key ID (5UJVG7K6L2).

#### Airship steps

You will need your downloaded .p8 file and noted Team, Bundle, and Key IDs from Apple steps.

Go to Go to Settings » Channels » Mobile Apps » iOS and create new iOS configurartion wirth the Token-based Authentication.

#### App setup steps

Open the project in XCode: `open ios/Runner.xcworkspace `

From Runner -> Signing & Capabilities adjust the team and the bundle identifier (com.atanashristov.airshipMessagingStaging).

Add the following capabilities to the application target:

- Push Notifications
- Background Modes > Remote Notifications

Create a plist file `AirshipConfig.plist` and include it in your application's target:

```xml
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>developmentAppKey</key>
  <string>4noZG...</string>
  <key>developmentAppSecret</key>
  <string>qgZg...</string>
  <key>productionAppKey</key>
  <string>4noZG...</string>
  <key>productionAppSecret</key>
  <string>qgZg...</string>
  <key>URLAllowListScopeOpenUrl</key>
  <array>
    <string>*</string>
  </array>
</dict>
</plist>
```

The file should be in subdirectory "ios\Runner" next to the Info.plist. Include it in the project from XCode.

Make sure that the iOS deployment target version (specified in Xcode) and the platform version (specified in your app’s Podfile) both match the current minimum target version. Mismatch between these versions can cause an “airship_flutter not found” error.

If you get “airship_flutter not found” error, run from `ios`:

```sh
pod repo update && pod install
```


