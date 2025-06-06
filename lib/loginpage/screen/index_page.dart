import 'package:clone_aom/loginpage/screen/components/main_menu.dart';
import 'package:clone_aom/loginpage/screen/login_page.dart';
import 'package:flutter/material.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User profile'),
        actions: [
          IconButton(
            onPressed: () => {},
            icon: Center(child: Icon(Icons.settings)),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('IndexPage'),
            IconButton(
              onPressed:
                  () => {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    ),
                  },
              icon: Icon(Icons.arrow_back),
            ),
          ],
        ),
      ),
      drawer: MainMenu(),
    );
  }
}
