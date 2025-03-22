import 'package:flutter/material.dart';
import 'package:frontend/utils/colors.dart';
import 'package:frontend/widgets/common/elevated_button_widget.dart';

class EventTypeButtonWidget extends StatelessWidget {
  final String value;
  final String label;
  final Function(String) onPressed;
  final bool isSelected;

  const EventTypeButtonWidget(this.value, this.label, this.onPressed, {this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Make buttons full width
      child: ElevatedButton(
      onPressed: () => onPressed(value),
      style: ElevatedButton.styleFrom(
        
        backgroundColor: isSelected ? outlineBlue : white, 
        foregroundColor: isSelected ? white : outlineBlue,
        side: BorderSide(color: outlineBlue),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: EdgeInsets.symmetric(vertical: 15.0),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600, // 600 weight
          fontSize: 16.0,
          color: isSelected ? white : textGray,
        ),
      ),
    )
  );
  }
}