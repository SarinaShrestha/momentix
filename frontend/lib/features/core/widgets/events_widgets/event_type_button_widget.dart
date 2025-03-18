import 'package:flutter/material.dart';

class EventTypeButtonWidget extends StatelessWidget {
  final String value;
  final String label;
  final Function(String) onPressed;

  const EventTypeButtonWidget(this.value, this.label, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Make buttons full width
      child: ElevatedButton(
        onPressed: () => onPressed(value),
        child: Text(label),
      ),
    );
  }
}