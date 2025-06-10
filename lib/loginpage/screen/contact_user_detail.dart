import 'package:flutter/material.dart';

class ContactUserDetail extends StatelessWidget {
  final String username;
  const ContactUserDetail({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(username)));
  }
}
