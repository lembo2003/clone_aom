import 'package:clone_aom/loginpage/screen/components/index_user_tiles.dart';
import 'package:clone_aom/loginpage/screen/components/main_menu.dart';
import 'package:clone_aom/loginpage/screen/pdf_test_page.dart';
import 'package:flutter/material.dart';

class IndexPage extends StatelessWidget {
  final String userId;

  const IndexPage({super.key, this.userId = '0'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        shadowColor: Colors.grey,
        title: Text(
          'User ID: $userId',
          style: TextStyle(fontFamily: "Montserrat"),
        ),
        actions: [
          IconButton(
            onPressed: () => {},
            icon: Center(child: Icon(Icons.settings)),
          ),
        ],
      ),
      body: Column(
        children: [
          IndexUserTiles(),
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PDFTestPage()),
              );
            },
            child: Text("Go to PDF DEMO"),
          ),
        ],
      ),
      drawer: MainMenu(),
    );
  }
}
