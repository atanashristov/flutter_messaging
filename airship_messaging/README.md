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
