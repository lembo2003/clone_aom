import 'package:clone_aom/firebase_options.dart';
import 'package:clone_aom/loginpage/screen/login_page.dart';
import 'package:clone_aom/loginpage/services/firebase_api.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  debugPrint("FCM_DEBUG: Firebase core initialized");

  try {
    await FirebaseApi().initNotification();
    debugPrint("FCM_DEBUG: Notification initialization completed");
  } catch (e) {
    debugPrint("FCM_ERROR: Error initializing notifications: $e");
  }

  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize("126c5868-73ff-49f7-aaf0-b30546856d6a");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LoginPage(),
    );
  }
}
