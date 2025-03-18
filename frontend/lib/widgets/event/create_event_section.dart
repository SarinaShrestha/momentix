import 'package:flutter/material.dart';

class CreateEventSectionWidget extends StatelessWidget {
  const CreateEventSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController eventController = TextEditingController();
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Text("Give your event a name", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text("How’d you like to call your event?\nDon't worry, you can always change it later.",
              textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: Colors.grey)),
          SizedBox(height: 20),
          TextField(
            controller: eventController,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              hintText: "Enter event name",
              contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              String eventName = eventController.text.trim();
              if (eventName.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Event '$eventName' Created!")),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            ),
            child: Text("Continue"),
          ),
        ],
      ),
    );
  }
}