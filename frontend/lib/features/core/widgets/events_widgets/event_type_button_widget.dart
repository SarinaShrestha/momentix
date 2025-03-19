import 'package:flutter/material.dart';
import 'package:frontend/utils/colors.dart';
import 'package:frontend/widgets/common/elevated_button_widget.dart';

class EventTypeButtonWidget extends StatelessWidget {
  final String value;
  final String label;
  final Function(String) onPressed;

  const EventTypeButtonWidget(this.value, this.label, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Make buttons full width
      child: ElevatedButtonWidget(
        onPressed: () => onPressed(value),
        buttonName: label, 
        color: outlineBlue,
      ),
    );
  }
}