import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/features/core/event_creation/controller/event_controller.dart';
import 'package:frontend/features/core/event_creation/widgets/event_type_button_widget.dart';
import 'package:frontend/features/core/event_creation/widgets/qr_display_widget.dart';
import 'package:frontend/repository/event_repository/event_repository.dart';
import 'package:frontend/utils/colors.dart';
import 'package:frontend/widgets/common/elevated_button_widget.dart';

class EventCreationFormWidget extends StatefulWidget {
  final Function (String, String, String, String) onEventCreated;

  EventCreationFormWidget({required this.onEventCreated});

  @override
  _EventCreationFormWidgetState createState() => _EventCreationFormWidgetState();
}

class _EventCreationFormWidgetState extends State<EventCreationFormWidget> {
  final TextEditingController _eventNameController = TextEditingController();
  String _eventDate = "";
  String _eventType = "";
  int _step = 0;
  final EventController _eventController = EventController();
  bool isQRCodeGenerated = false;


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2027)
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
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // User is not authenticated
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("You must be logged in to create an event.")),
      );
      return;
    }


    final String eventName = _eventNameController.text;
    final String creatorId = FirebaseAuth.instance.currentUser!.uid;

    final String? nameError = _eventController.validateEventName(eventName);
    final String? dateError = _eventController.validateEventDate(_eventDate);
    final String? typeError = _eventController.validateEventType(_eventType);

    if (nameError != null || dateError != null || typeError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(nameError ?? dateError ?? typeError!)),
      );
      return;
    }

    try {

      String eventId = await _eventController.createEvent(
        eventName: eventName,
        eventDate: _eventDate,
        eventType: _eventType,
      );

      widget.onEventCreated(eventId, eventName, _eventDate, _eventType);

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
              if (_step < 2)
                Text(
                  _step == 0
                  ? "Give your event a name"
                  : "Select the event date",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16),
                ),
              
              if (_step == 2)
                Text(
                  "What type of event is it?",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16)
                ),

              SizedBox(height: 30),

              if (_step == 0)
                TextField(
                  controller: _eventNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    hintText: "Event Name",
                  ),
                  style: Theme.of(context).textTheme.bodyMedium
                )
              else if (_step == 1) 
                Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.62 ,
                      child: TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                          hintText: _eventDate.isEmpty ? "Select Date" : "Selected: $_eventDate",
                        ),
                      ),
                    ),
                    IconButton(onPressed: () => _selectDate(context), icon: Icon(Icons.calendar_month_outlined), iconSize: size.width * 0.1,)
                  ],
                )
              else if(_step ==2)
                Column(
                  children: [
                    EventTypeButtonWidget("Wedding", "💍 Wedding", 
                    (value) {
                      setState(() {
                        _eventType = value;
                      });
                    },
                      isSelected : _eventType == "Wedding",
                    ),
                    SizedBox(height: size.height * 0.01,),
                    EventTypeButtonWidget("Party", "🎉 Party", 
                    (value) {
                      setState(() {
                        _eventType = value;
                      });
                    },
                      isSelected : _eventType == "Party",
                    ),
                    SizedBox(height: size.height * 0.01,),
                    EventTypeButtonWidget("Conference", "🎤 Conference", 
                    (value) {
                      setState(() {
                        _eventType = value;
                      });
                    },
                      isSelected : _eventType == "Conference",
                    ),
                    SizedBox(height: size.height * 0.01,),
                    EventTypeButtonWidget("Birthday", "🎂 Birthday", 
                    (value) {
                      setState(() {
                        _eventType = value;
                      });
                    },
                      isSelected : _eventType == "Birthday",
                    ),
                    SizedBox(height: size.height * 0.01,),
                    EventTypeButtonWidget("Other", "❓ Other", 
                    (value) {
                      setState(() {
                        _eventType = value;
                      });
                    },
                      isSelected : _eventType == "Other",
                    ),
                  ],
                ),
    
              SizedBox(height: 40),
              if (_step < 2)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButtonWidget(
                    onPressed: () {
                      if (_step == 0 && _eventNameController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Please enter an event name.")),
                        );
                      } else if (_step == 1 && _eventDate.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Please select a date.")),
                        );
                      } else {
                        _onNextStep(_step == 0 ? _eventNameController.text : _eventDate);
                      }
                    },
                    buttonName: "Continue",
                    color: outlineBlue,
                  ),
                ),
              
              SizedBox(height: 20,),
              if (_step >= 2)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButtonWidget(
                    onPressed: _createEvent,
                    buttonName: "Create Event",
                    color: outlineBlue,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}