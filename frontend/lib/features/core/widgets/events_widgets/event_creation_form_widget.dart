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
    final size = MediaQuery.of(context).size;
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
                Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.62 ,
                      child: TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                          hintText: eventDate.isEmpty ? "Select Date" : "Selected: $eventDate",
                        ),
                      ),
                    ),
                    IconButton(onPressed: onSelectDate, icon: Icon(Icons.calendar_month_outlined), iconSize: size.width * 0.1,)
                  ],
                )
              else
                Column(
                  children: [
                    EventTypeButtonWidget("Wedding", "💍 Wedding", onNextStep),
                    SizedBox(height: size.height * 0.01,),
                    EventTypeButtonWidget("Party", "🎉 Party", onNextStep),
                    SizedBox(height: size.height * 0.01,),
                    EventTypeButtonWidget("Conference", "🎤 Conference", onNextStep),
                    SizedBox(height: size.height * 0.01,),
                    EventTypeButtonWidget("Birthday", "🎂 Birthday", onNextStep),
                    SizedBox(height: size.height * 0.01,),
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