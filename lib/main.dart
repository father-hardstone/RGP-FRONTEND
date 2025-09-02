import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rgp_landing_take_3/app.dart';
import 'package:rgp_landing_take_3/config.dart';
import 'package:flutter/foundation.dart' show kReleaseMode;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    if (!kReleaseMode) {
      await dotenv.load(fileName: ".env");
    }

    runApp(const RgpApp());
  } catch (e) {
    runApp(MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error, size: 64, color: Colors.red),
              SizedBox(height: 16),
              Text(
                'Configuration Error',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Environment variables not properly configured',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}