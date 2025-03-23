import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  final String eventId;
  final String eventName;
  final String eventDate;
  final String eventType;
  final String creatorId;
  final DateTime createdAt;
  final List<String> attendees;

  EventModel({
    required this.eventId,
    required this.eventName,
    required this.eventDate,
    required this.eventType,
    required this.creatorId,
    required this.createdAt,
    required this.attendees,
  });

  // Convert Firestore document to Event object
  factory EventModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return EventModel(
      eventId: doc.id,
      eventName: data['Event Name'],
      eventDate: data['Event Date'],
      eventType: data['Event Type'],
      creatorId: data['Creator Id'],
      createdAt: (data['Created At'] as Timestamp).toDate(),
      attendees: List<String>.from(data['Attendees'] ?? []),
    );
  }

  // Convert Event object to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'eventName': eventName,
      'eventDate': eventDate,
      'eventType': eventType,
      'creatorId': creatorId,
      'createdAt': Timestamp.fromDate(createdAt),
      'attendees': attendees,
    };
  }

  toJson() {
    return {
      "Event Id": eventId,
      "Event Name": eventName,
      "Event Date": eventDate,
      "Event Type" : eventType,
      'Creator Id': creatorId,
      "Attendees": attendees,
      "Created At": createdAt
    };
  }
}