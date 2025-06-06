import 'package:clone_aom/loginpage/screen/components/index_user_tiles.dart';
import 'package:clone_aom/loginpage/screen/components/main_menu.dart';
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
      body: IndexUserTiles(),
      drawer: MainMenu(),
    );
  }
}
