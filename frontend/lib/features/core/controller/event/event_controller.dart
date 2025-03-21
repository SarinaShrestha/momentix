import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/repository/authentication_repository/event_repository/event_repository.dart';

class EventController {
  final EventRepository _eventRepository = EventRepository();

  // Validate event name
  String? validateEventName(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter an event name.";
    }
    return null;
  }

  // Validate event date
  String? validateEventDate(String? value) {
    if (value == null || value.isEmpty) {
      return "Please select a date.";
    }
    return null;
  }

  // Validate event type
  String? validateEventType(String? value) {
    if (value == null || value.isEmpty) {
      return "Please select an event type.";
    }
    return null;
  }

  // Create an event
  Future<String> createEvent({
    required String eventName,
    required String eventDate,
    required String eventType,
  }) async {
    final String creatorId = FirebaseAuth.instance.currentUser!.uid;

    try {
      print("$eventName, $eventDate, $eventType");
      String eventId = await _eventRepository.addEvent(
        eventName: eventName,
        eventDate: eventDate,
        eventType: eventType,
        creatorId: creatorId,
      );
      return eventId;
    } catch (e) {
      throw e; // Rethrow the error for handling in the UI
    }
  }
}