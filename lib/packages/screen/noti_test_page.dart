import 'package:clone_aom/packages/services/noti_service.dart';
import 'package:flutter/material.dart';

class NotiTestPage extends StatefulWidget {
  const NotiTestPage({super.key});

  @override
  State<NotiTestPage> createState() => _NotiTestPageState();
}

class _NotiTestPageState extends State<NotiTestPage> {
  final _notiService = NotiService();
  final _titleController = TextEditingController(text: 'Test Notification');
  final _bodyController = TextEditingController(text: 'This is a test notification');

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notification Test')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Notification Title',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _bodyController,
              decoration: const InputDecoration(
                labelText: 'Notification Body',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                await _notiService.showNotification(
                  id: 0,
                  title: _titleController.text,
                  body: _bodyController.text,
                  payload: "test_payload",
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Send Notification',
                style: TextStyle(fontSize: 16),
              ),
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
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
