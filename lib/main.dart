import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rgp_landing_take_3/app.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const RgpApp());
}
