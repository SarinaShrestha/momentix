import 'package:flutter/material.dart';
import 'package:frontend/features/core/views/events/qrscanner.dart';

class JoinEventSectionWidget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QRScannerPage()),
    );
    return Container(); 
  }
}