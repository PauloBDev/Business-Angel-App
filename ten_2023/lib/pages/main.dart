import 'package:flutter/material.dart';
import 'package:tg2/pages/auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'controllers/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Business Angels App',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const AuthPage(),
    );
  }
}
