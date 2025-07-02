import 'package:clone_aom/packages/services/noti_service.dart';
import 'package:flutter/material.dart';

class NotiTestPage extends StatefulWidget {
  const NotiTestPage({super.key});

  @override
  State<NotiTestPage> createState() => _NotiTestPageState();
}

class _NotiTestPageState extends State<NotiTestPage> {
  final _notiService = NotiService();
  int _notificationId = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await _notiService.showNotification(
                  id: _notificationId++,
                  title: "Test Notification",
                  body: "This is a test notification #${_notificationId}",
                  payload: "test_payload",
                );
              },
              child: const Text('Send Basic Notification'),
            ),
            const SizedBox(height: 20),
            Text(
              _notiService.isInitialized 
                ? 'Notifications are initialized'
                : 'Notifications are NOT initialized',
              style: TextStyle(
                color: _notiService.isInitialized ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
