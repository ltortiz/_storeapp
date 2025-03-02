import 'package:flutter/material.dart';
import 'package:storeapp/app/di/dependency_injection.dart';
import 'package:storeapp/app/main_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  DependencyInjection.setup();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}
