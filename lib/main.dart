import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rgp_landing_take_3/app.dart';
import 'package:rgp_landing_take_3/config.dart';
import 'package:flutter/foundation.dart' show kReleaseMode;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  print('🔧 [DEBUG] Initializing environment variables...');

  try {
    if (!kReleaseMode) {
      // Local development: load .env
      await dotenv.load(fileName: ".env");
      print('✅ [DEBUG] .env loaded successfully for local development');

      print('🔍 [DEBUG] Environment Variables (local):');
      print('  - BACKEND_API_URL: ${dotenv.env['BACKEND_API_URL'] ?? 'NOT_FOUND'}');
      print('  - ENQUIRY_ENDPOINT: ${dotenv.env['ENQUIRY_ENDPOINT'] ?? 'NOT_FOUND'}');

      print('🔍 [DEBUG] All Available Environment Variables:');
      dotenv.env.forEach((key, value) {
        print('  - $key: $value');
      });
    } else {
      // Production: use --dart-define values
      print('✅ [DEBUG] Skipping .env loading (production mode)');

      print('🔍 [DEBUG] Environment Variables (production via dart-define):');
      print('  - BACKEND_API_URL: ${Config.backendApiUrl}');
      print('  - ENQUIRY_ENDPOINT: ${Config.enquiryEndpoint}');
      print('  - FULL_ENQUIRY_URL: ${Config.fullEnquiryUrl}');
    }

    runApp(const RgpApp());
  } catch (e) {
    print('❌ [DEBUG] Failed to initialize environment variables: $e');

    // Show error screen instead of crashing
    runApp(MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              const Text(
                'Configuration Error',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
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
