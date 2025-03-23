import 'package:flutter/material.dart';
import 'package:flutter_ucs_app/constants.dart';
import 'package:flutter_ucs_app/booking_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/logo.png', width: 30),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: primaryColor),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Stops it stretching vertically
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
                onPressed: () => navigateToLocation(context, 'Taunton'),
                child: const Text('Taunton', style: TextStyle(color: secondaryColor)),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
                onPressed: () => navigateToLocation(context, 'Bridgwater'),
                child: const Text('Bridgwater', style: TextStyle(color: secondaryColor)),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
                onPressed: () => navigateToLocation(context, 'Cannington'),
                child: const Text('Cannington', style: TextStyle(color: secondaryColor)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToLocation(BuildContext context, String location) {
    Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => BookingPage(location)),
);
  }
}
