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
  String _displayText = '';

  void _loadJsonData() async {
  final jsonString = await rootBundle.loadString('assets/lang.json');
  final jsonData = jsonDecode(jsonString);

  String displayText = '';

  jsonData.forEach((key, value) {
    displayText += '$key:\n';
    if (value is Map) {
      value.forEach((subKey, subValue) {
        displayText += '  $subKey: $subValue\n';
      });
    } else {
      displayText += '  $value\n';
    }
  });

  setState(() {
    _displayText = displayText;
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lang Test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_displayText),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loadJsonData,
              child: Text('Load JSON Data'),
            ),
          ],
        ),
      ),
    );
  }
}