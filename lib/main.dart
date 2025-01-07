import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lang Test',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, dynamic> _translations = {};
  String _selectedLanguage = 'en';

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTranslations();
  }

  Future<void> _loadTranslations() async {
    final jsonString = await rootBundle.loadString('assets/lang.json');
    setState(() {
      _translations = jsonDecode(jsonString);
    });
  }

  String _getTranslation(String key) {
    return _translations[key]?[_selectedLanguage] ?? key;
  }

  void _changeLanguage(String languageCode) {
    setState(() {
      _selectedLanguage = languageCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lang Test'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => _showLanguageSelectionDialog(),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: _getTranslation('login'),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: _getTranslation('password'),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Perform login action here
                  print('Username: ${_usernameController.text}');
                  print('Password: ${_passwordController.text}');
                },
                child: Text(_getTranslation('login')),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  // Handle forgot password action here
                  print('Forgot Password clicked');
                },
                child: Text(_getTranslation('forgotPassword')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLanguageSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLanguageOption('English', 'en'),
              _buildLanguageOption('Français', 'fr'),
              _buildLanguageOption('Español', 'es'),
              _buildLanguageOption('Deutsch', 'de'),
              _buildLanguageOption('中文', 'zh'),
              _buildLanguageOption('Tiếng Việt', 'vi'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(String language, String code) {
    return ListTile(
      title: Text(language),
      onTap: () {
        _changeLanguage(code);
        Navigator.of(context).pop();
      },
    );
  }
}
