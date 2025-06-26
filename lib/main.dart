import 'package:clone_aom/firebase_options.dart';
import 'package:clone_aom/packages/screen/auth/login_page.dart';
import 'package:clone_aom/packages/services/firebase_api.dart';
import 'package:clone_aom/providers/language_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';

import 'l10n/app_localizations.dart';

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

  runApp(
    ChangeNotifierProvider(create: (_) => LanguageProvider(), child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en'), Locale('vi')],
          locale: languageProvider.currentLocale,
          home: const LoginPage(),
        );
      },
    );
  }
}
