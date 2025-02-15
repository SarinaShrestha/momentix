import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Header with title and subtitle
            Container(
              color: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Column(
                children: [
                  Text(
                    'Momentix',
                    style: TextStyle(
                      fontFamily: 'YourCustomFont', // Ensure this font is added to your project
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'MEMORY MADE SIMPLE',
                    style: TextStyle(
                      fontFamily: 'YourCustomFont',
                      fontSize: 14,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Welcome section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi, Sarina!',
                    style: TextStyle(
                      fontFamily: 'YourCustomFont',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Welcome to Momentix!',
                    style: TextStyle(
                      fontFamily: 'YourCustomFont',
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Description section
            Container(
              color: Color(0xFFDDEEFF), // Light blue background
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'Your Memories, Just a Tap Away!',
                    style: TextStyle(
                      fontFamily: 'YourCustomFont',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Here’s your hub for reliving your favorite event moments.',
                    style: TextStyle(
                      fontFamily: 'YourCustomFont',
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Card section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Ready to relive your favourite moments?',
                      style: TextStyle(
                        fontFamily: 'YourCustomFont',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Your latest event’s pictures are just a click away!',
                      style: TextStyle(
                        fontFamily: 'YourCustomFont',
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Action for the button
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFFC107), // Custom yellow color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'My moments',
                        style: TextStyle(
                          fontFamily: 'YourCustomFont',
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40),
            // Footer text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Remember every moment with Momentix.',
                style: TextStyle(
                  fontFamily: 'YourCustomFont',
                  fontSize: 14,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            // Bottom navigation (if applicable)
            Container(
              padding: EdgeInsets.only(top: 8),
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.home),
                    color: Color(0xFFFFC107),
                    onPressed: () {
                      // Home action
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
