import 'package:clone_aom/l10n/app_localizations.dart';
import 'package:clone_aom/packages/screen/components/auth/login_tiles.dart';
import 'package:clone_aom/packages/screen/index_page.dart';
import 'package:clone_aom/packages/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();

  bool _isLoading = false;

  void _handleLogin() async {
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter username and password')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _authService.login(
        _usernameController.text,
        _passwordController.text,
      );

      if (response.success) {
        // Navigate to index page with user ID
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (context) => IndexPage(userId: response.data.userId ?? '0'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: ${response.message}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void openNewCreateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              AppLocalizations.of(context)!.loginText,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: "Montserrat",
              ),
            ),
          ),
          insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          content: SizedBox(
            height: 300,
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.people_alt_rounded),
                      hintText: AppLocalizations.of(context)!.userName,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.key),
                      hintText: AppLocalizations.of(context)!.password,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: false,
                      onChanged: (value) {
                        // Handle checkbox state change
                      },
                    ),
                    Text(
                      AppLocalizations.of(context)!.defaultSession,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "Montserrat",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.black,
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      padding: EdgeInsets.symmetric(vertical: 0),
                    ),
                    child:
                        _isLoading
                            ? CircularProgressIndicator()
                            : Text(
                              AppLocalizations.of(context)!.loginText,
                              style: TextStyle(fontFamily: "Montserrat"),
                            ),
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
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 50),
            child: Center(
              child: Image(
                height: 200,
                width: 200,
                image: AssetImage(
                  'assets/images/loginscreen/intechno_logo.png',
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue, width: 1.5),
                ),
                child: IconButton(
                  onPressed: () => openNewCreateDialog(context),
                  icon: Icon(Icons.add, size: 40),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              children: [LoginTiles(name: 'toila', url: 'intechno.io.vn')],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppLocalizations.of(context)!.loginScreen_rights,
                  style: TextStyle(fontFamily: "Montserrat"),
                ),
                Text(
                  AppLocalizations.of(context)!.loginScreen_version,
                  style: TextStyle(fontFamily: "Montserrat"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
