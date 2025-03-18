import 'package:flutter/material.dart';
import 'package:frontend/features/core/widgets/events_widgets/event_type_button_widget.dart';
import 'package:frontend/utils/colors.dart';
import 'package:frontend/widgets/common/elevated_button_widget.dart';

class EventCreationFormWidget extends StatelessWidget {
  final int step;
  final TextEditingController controller;
  final String eventDate;
  final VoidCallback onSelectDate;
  final Function(String) onNextStep;

  const EventCreationFormWidget({
    required this.step,
    required this.controller,
    required this.eventDate,
    required this.onSelectDate,
    required this.onNextStep,
  });

  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                step == 0
                    ? "Give your event a name"
                    : step == 1
                        ? "Select the event date"
                        : "What kind of event is it?",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16),
              ),
              SizedBox(height: 30),
              if (step == 0)
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    hintText: "Event Name",
                  ),
                  style: Theme.of(context).textTheme.bodyMedium
                )
              else if (step == 1) 
                ElevatedButtonWidget(
                  onPressed: onSelectDate,
                  buttonName: eventDate.isEmpty ? "Select Date" : "Selected: $eventDate",
                  color: outlineBlue,
                  )
              else
                Column(
                  children: [
                    EventTypeButtonWidget("Wedding", "💍 Wedding", onNextStep),
                    EventTypeButtonWidget("Party", "🎉 Party", onNextStep),
                    EventTypeButtonWidget("Conference", "🎤 Conference", onNextStep),
                    EventTypeButtonWidget("Birthday", "🎂 Birthday", onNextStep),
                    EventTypeButtonWidget("Other", "❓ Other", onNextStep),
                  ],
                ),
    
              SizedBox(height: 40),
              if (step < 2)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButtonWidget(
                    onPressed: () => onNextStep(controller.text),
                    buttonName: "Continue",
                    color: outlineBlue,
                  ),
                ),
              
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}