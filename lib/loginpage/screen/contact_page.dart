import 'package:clone_aom/loginpage/screen/components/main_menu.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts", style: TextStyle(fontFamily: "Montserrat")),
      ),
      drawer: MainMenu(),
    );
  }
}
