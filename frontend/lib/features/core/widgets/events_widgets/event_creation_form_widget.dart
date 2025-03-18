import 'package:flutter/material.dart';
import 'package:frontend/features/core/widgets/events_widgets/event_type_button_widget.dart';

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
    return Card(
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
            ),
            SizedBox(height: 15),
            if (step == 0)
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Event Name",
                ),
              )
            else if (step == 1)
              ElevatedButton(
                onPressed: onSelectDate,
                child: Text(eventDate.isEmpty ? "Select Date" : "Selected: $eventDate"),
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
            SizedBox(height: 15),
            if (step < 2)
              ElevatedButton(
                onPressed: () => onNextStep(controller.text),
                child: Text("Continue"),
              ),
          ],
        ),
      ),
    );
  }
}