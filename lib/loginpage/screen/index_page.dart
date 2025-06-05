import 'package:flutter/material.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User profile')),
      body: Center(child: Text('IndexPage')),
      drawer: Drawer(
        child: Scaffold(
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Container(
              color: Colors.white, // Background color for the drawer
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  Container(
                    color: Colors.blue,
                    height: 150,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      'Full-Screen Drawer',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        ListTile(
                          leading: Icon(Icons.home),
                          title: Text('Home'),
                          onTap: () {
                            Navigator.pop(context); // Close the drawer
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.settings),
                          title: Text('Settings'),
                          onTap: () {
                            Navigator.pop(context); // Close the drawer
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.logout),
                          title: Text('Logout'),
                          onTap: () {
                            Navigator.pop(context); // Close the drawer
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
