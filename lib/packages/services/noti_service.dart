import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotiService {
  static final NotiService _instance = NotiService._internal();
  factory NotiService() => _instance;
  NotiService._internal();

  final notificationsPlugin = FlutterLocalNotificationsPlugin();
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  //INIT
  Future<void> initNotification() async {
    if (_isInitialized) return; //prevent reinit

    try {
      //prepare android init settings
      const initSettingAndroid = AndroidInitializationSettings(
        '@mipmap/ic_launcher',
      );
      
      //prepare ios init settings
      const initSettingIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );

      //init setting
      const initSetting = InitializationSettings(
        android: initSettingAndroid,
        iOS: initSettingIOS,
      );

      //init the plugin
      await notificationsPlugin.initialize(
        initSetting,
        onDidReceiveNotificationResponse: (details) {
          // Handle notification tap
          print('Notification tapped: ${details.payload}');
        },
      );

      // Check if we can request permissions
      final platform = notificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
          
      if (platform != null) {
        // For Android 13 and above
        final granted = await platform.requestNotificationsPermission();
        if (granted ?? false) {
          print('Notification permissions granted');
          _isInitialized = true;
        } else {
          print('Notification permissions denied');
        }
      } else {
        // For older Android versions or iOS
        _isInitialized = true;
        print('Platform-specific implementation not available');
      }
    } catch (e) {
      print('Error initializing notifications: $e');
    }
  }

  //NOTI detail setup
  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_channel_id',
        'Daily Notifications',
        channelDescription: 'Daily Notifications',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: true,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );
  }

  //SHOW noti
  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    if (!_isInitialized) {
      print('Notifications not initialized');
      return;
    }

    try {
      await notificationsPlugin.show(
        id,
        title,
        body,
        notificationDetails(),
        payload: payload,
      );
      print('Notification sent successfully');
    } catch (e) {
      print('Error showing notification: $e');
    }
  }

  //On noti tap
}
