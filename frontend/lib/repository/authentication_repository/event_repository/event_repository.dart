import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frontend/features/authentication/model/user_model.dart';
import 'package:frontend/repository/authentication_repository/authentication_repository.dart';
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
      DocumentReference docRef = await _db.collection('Events').add({
        'Event Name': eventName,
        "Event Date": eventDate,
        "Event Type": eventType,
        "Creator Id": creatorId,
        "Created At": Timestamp.now(),
        "Attendees": [],
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

  Future<void> updateUserDetails(UserModel user) async {
    await _db.collection("Users").doc(user.id).update(user.toJson());
  }

 
}