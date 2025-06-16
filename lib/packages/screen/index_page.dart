import 'package:clone_aom/l10n/app_localizations.dart';
import 'package:clone_aom/packages/screen/components/index_user_tiles.dart';
import 'package:clone_aom/packages/screen/components/main_menu.dart';
import 'package:clone_aom/packages/screen/pdf_test_page.dart';
import 'package:clone_aom/providers/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IndexPage extends StatelessWidget {
  final String userId;

  const IndexPage({super.key, this.userId = '0'});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

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
            child: Text(localizations!.goToPdfDemo),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  localizations.selectLanguage + ': ',
                  style: TextStyle(fontSize: 16),
                ),
                Consumer<LanguageProvider>(
                  builder: (context, languageProvider, child) {
                    return DropdownButton<String>(
                      value: languageProvider.currentLocale.languageCode,
                      items: [
                        DropdownMenuItem(
                          value: 'en',
                          child: Text(localizations.english),
                        ),
                        DropdownMenuItem(
                          value: 'vi',
                          child: Text(localizations.vietnamese),
                        ),
                      ],
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          languageProvider.setLanguage(newValue);
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: MainMenu(),
    );
  }
}
