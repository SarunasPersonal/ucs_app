import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_ucs_app/constants.dart';
import 'package:flutter_ucs_app/home_page.dart';
import 'package:flutter_ucs_app/create_user_page.dart';
import 'package:flutter_ucs_app/forgot_password_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

Future<void> loginUser(String username, String password, BuildContext context) async {
  final url = Uri.parse('http://127.0.0.1:8000/api-token-auth/');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'username': username,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final token = data['token'];

    // Store the token securely
    await storage.write(key: 'auth_token', value: token);

    // Navigate to the HomePage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  } else {
    // Show an error message if login fails
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Invalid credentials. Please try again.')),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Email Address Field
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email Address',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Password Field
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Login Button that calls the API
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                    ),
                    onPressed: () {
                      final username = emailController.text;
                      final password = passwordController.text;
                      loginUser(username, password, context);
                    },
                    child: const Text(
                      'LOG IN',
                      style: TextStyle(color: secondaryColor),
                    ),
                  ),
                  // Create User Button
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CreateUserPage()),
                      );
                    },
                    child: const Text(
                      'CREATE USER',
                      style: TextStyle(color: primaryColor),
                    ),
                  ),
                  // Forgot Password Button
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ForgotPasswordPage()),
                      );
                    },
                    child: const Text(
                      'FORGOT PASSWORD?',
                      style: TextStyle(color: primaryColor),
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
