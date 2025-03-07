import 'package:flutter/material.dart';
import 'package:flutter_ucs_app/loading_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LoadingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
