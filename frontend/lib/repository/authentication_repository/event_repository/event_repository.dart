import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frontend/features/core/model/event_model.dart';

import 'package:get/get.dart';

class EventRepository extends GetxController{
  static EventRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<String> addEvent({
    required String eventName, 
    required String eventDate,
    required String eventType,
    required String creatorId
    }) async{
    try {
      DocumentReference docRef = _db.collection('Events').doc();

      docRef.set({
        "Event Id": docRef.id,        
        'Event Name': eventName,
        "Event Date": eventDate,
        "Event Type": eventType,
        "CreatorId": creatorId,
        "Created At": Timestamp.now(),
        "Attendees": [],
        "QR Code Url": "",
      });

      return docRef.id;

    } catch(error) {
      print("Error adding event to Firestore: $error");
      throw Exception("Failed to add event");
    }
  }

  //Add attendee to the event
  Future<void> addAttendee({
    required String eventId,
    required String attendeeId
  }) async{
    try{
      await _db.collection('Events').doc(eventId).update({
        'Attendees': FieldValue.arrayUnion([attendeeId])
      });
    } catch (error) {
      print("Error adding attendee: $error");
      throw error;
    }
  }

  Future<void> updateEventDetails(EventModel event) async {
    await _db.collection("Users").doc(event.eventId).update(event.toJson());
  }

  Future<void> storeQRCodeUrl(String eventId, String qrCodeUrl) async {
    try {
      await _db.collection('Events').doc(eventId).update({
        'QR Code Url': qrCodeUrl,
      });
    } catch (e) {
      print("Error storing QR code URL: $e");
      throw Exception("Failed to store QR code URL");
    }
  }

  // Retrieve QR code URL from Firestore
  Future<String> getQRCodeUrl(String eventId) async {
    try {
      final doc = await _db.collection('Events').doc(eventId).get();
      return doc['QR Code Url'];
    } catch (e) {
      print("Error retrieving QR code URL: $e");
      throw Exception("Failed to retrieve QR code URL");
    }
  }
}


 