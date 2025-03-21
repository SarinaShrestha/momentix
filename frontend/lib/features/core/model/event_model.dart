import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String eventId;
  final String eventName;
  final String eventDate;
  final String eventType;
  final String creatorId;
  final DateTime createdAt;
  final List<String> attendees;

  Event({
    required this.eventId,
    required this.eventName,
    required this.eventDate,
    required this.eventType,
    required this.creatorId,
    required this.createdAt,
    required this.attendees,
  });

  // Convert Firestore document to Event object
  factory Event.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Event(
      eventId: doc.id,
      eventName: data['eventName'],
      eventDate: data['eventDate'],
      eventType: data['eventType'],
      creatorId: data['creatorId'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      attendees: List<String>.from(data['attendees'] ?? []),
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
}