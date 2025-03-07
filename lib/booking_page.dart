import 'package:flutter/material.dart';
import 'package:flutter_ucs_app/constants.dart';

class BookingPage extends StatefulWidget {
  final String location;

  const BookingPage(this.location, {super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime? selectedDateTime;

  void _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2026),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  void _confirmBooking() {
    if (selectedDateTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a date and time')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Booking confirmed for ${widget.location} at $selectedDateTime')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Booking - ${widget.location}',
          style: const TextStyle(color: primaryColor),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Welcome to ${widget.location} Booking Page',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,  // Use primaryColor from constants.dart
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
                onPressed: () => _selectDateTime(context),
                child: Text(
                  selectedDateTime == null ? 'Select Date & Time' : 'Change Date & Time',
                  style: const TextStyle(color: secondaryColor),
                ),
              ),
              if (selectedDateTime != null) ...[
                const SizedBox(height: 10),
                Text(
                  'Selected: ${selectedDateTime.toString()}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: primaryColor,
                  ),
                ),
              ],
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
                onPressed: _confirmBooking,
                child: const Text(
                  'Confirm Booking',
                  style: TextStyle(color: secondaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
