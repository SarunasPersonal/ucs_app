import 'dart:async'; // Import Timer for delaying actions
import 'package:flutter/material.dart'; // Import Flutter material package

// Entry point of the Flutter application
void main() {
  runApp(const MyApp()); // Run the MyApp widget
}

// Root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoadingScreen(), // Set the initial screen to LoadingScreen
      debugShowCheckedModeBanner: false, // Remove the debug banner
    );
  }
}

// Loading screen widget displaying a fade-in and fade-out animation
class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller; // Controls animation timing
  late Animation<double> _animation; // Animation for fading

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller with a 6-second duration
    _controller = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    );

    // Define the animation sequence (fade-in, hold, fade-out)
    _animation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 20), // Fade-in
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 20), // Hold fully visible
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 20), // Fade-out
    ]).animate(_controller);

    // Start the animation
    _controller.forward();

    // Navigate to LoginScreen after 6 seconds
    Timer(const Duration(seconds: 6), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build loading screen UI
    return Scaffold(
      backgroundColor: const Color(0xFFAD1E3C), // Background color
      body: Center(
        child: FadeTransition(
          opacity: _animation, // Apply fade transition
          child: Image.asset(
            'assets/logo.png', // Display logo image
            width: 200,
          ),
        ),
      ),
    );
  }
}

// Login screen widget with email and password fields
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Build login screen UI
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFAD1E3C), // AppBar color
        title: const Text(
          'Login',
          style: TextStyle(color: Color(0xFFEECB28)), // AppBar text color
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400), // Limit form width
            child: Padding(
              padding: const EdgeInsets.all(24.0), // Padding around form
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Email input field
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFAD1E3C)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20), // Space between fields
                  // Password input field
                  TextField(
                    obscureText: true, // Hide password text
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFAD1E3C)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20), // Space before buttons
                  // Login button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFAD1E3C), // Button color
                    ),
                    onPressed: () {},
                    child: const Text(
                      'LOG IN',
                      style: TextStyle(color: Color(0xFFEECB28)), // Button text color
                    ),
                  ),
                  // Forgot password button
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'FORGOT PASSWORD?',
                      style: TextStyle(color: Color(0xFFAD1E3C)), // Button text color
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
