import 'package:flutter/material.dart';
import 'package:frontend/features/core/controller/event/event_controller.dart';
import 'package:frontend/repository/authentication_repository/event_repository/event_repository.dart';

class EventCreationFormWidget extends StatefulWidget{
  @override
  _EventCreationFormWidgetState createState() => _EventCreationFormWidgetState();
}
class _EventCreationFormWidgetState extends State<EventCreationFormWidget>{
  final TextEditingController _eventNameController = TextEditingController();
  String _eventDate = "";
  String _eventType = "";
  int _step = 0;
  final EventController _eventController = EventController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2027),
    );
    if (picked != null) {
      setState(() {
        _eventDate = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  void _onNextStep(String value) {
    setState(() {
      if (_step == 0) {
        _eventNameController.text = value;
      } else if (_step == 1) {
        _eventDate = value;
      } else if (_step == 2) {
        _eventType = value;
      }
      _step++;
    });
  }

  Future<void> _createEvent() async {
    final String eventName = _eventNameController.text;

    try {
      String eventId = await _eventController.createEvent(
        eventName: eventName,
        eventDate: _eventDate,
        eventType: _eventType,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Event created successfully! Event ID: $eventId")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to create event: $e")),
      );
    }
  }
  

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