import 'package:clone_aom/loginpage/screen/components/login_tiles.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  void openNewCreateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              'Create a session',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          insetPadding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 40,
          ), // Controls max width/height
          content: SizedBox(
            height: 400,
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.account_box),
                      hintText: 'Session name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.link),
                      hintText: 'Url',
                      suffixIcon: Icon(Icons.qr_code),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.people_alt_rounded),
                      hintText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.key),
                      hintText: 'Password',
                      suffixIcon: Icon(Icons.remove_red_eye),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                //Check box default session
                Row(
                  children: [
                    Checkbox(
                      value: false,
                      onChanged: (value) {
                        // Handle checkbox state change
                      },
                    ),
                    Text(
                      'Default session?',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                //Login button
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle login action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.black,
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      padding: EdgeInsets.symmetric(vertical: 0),
                    ),
                    child: Text('Login'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Logo Image
          Padding(
            padding: EdgeInsets.only(top: 50),
            child: Center(
              child: Image(
                height: 200,
                width: 200,
                image: AssetImage('assets/images/loginscreen/Logo_Axelor.png'),
              ),
            ),
          ),
          // The plus button
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color:
                        Colors.blue, // Change this to your desired border color
                    width: 1.5, // Border thickness
                  ),
                ),
                child: IconButton(
                  onPressed: () => openNewCreateDialog(context),
                  icon: Icon(Icons.add, size: 40),
                ),
              ),
            ),
          ),
          // Scrollable login tiles
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              children: [
                LoginTiles(name: 'toila', url: 'axelor.com.vn'),
                LoginTiles(name: 'toila user', url: 'axelor.com.vn'),

                LoginTiles(
                  name: 'toila mobile',
                  url: 'axelor.com.vnnnnnnnnnnnnnn',
                ),
                // Add more LoginTiles as needed
              ],
            ),
          ),
          // Footer text
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('@ 2005 - 2025 Axelor. All rights reserved.'),
                Text('Version 8.3.5'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
