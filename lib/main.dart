import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoadingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 6), // total duration of 6 seconds
      vsync: this,
    );

    _animation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 20), // Fade in (2 sec)
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 20), // Fully visible (2 sec)
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 20), // Fade out (2 sec)
    ]).animate(_controller);

    _controller.forward();

    // Navigate to next screen after animation completes
    Timer(const Duration(seconds: 6), () {
      
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFAD1E3C), //background color
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Image.asset(
            'assets/logo.png', // Path to logo
            width: 200, // Logo size
          ),
        ),
      ),
    );
  }
}
 