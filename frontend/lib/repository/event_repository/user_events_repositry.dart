import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserEventsRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<Map<String, dynamic>>> fetchUserEvents() async {
    String userId = _auth.currentUser!.uid;

    // Fetch events where the user is the creator
    QuerySnapshot createdEventsSnapshot = await _firestore
        .collection('Events')
        .where('CreatorId', isEqualTo: userId)
        .get();

    // Fetch events where the user is an attendee
    QuerySnapshot joinedEventsSnapshot = await _firestore
        .collection('Events')
        .where('Attendees', arrayContains: userId)
        .get();

    List<Map<String, dynamic>> allEvents = [];

    for (var doc in createdEventsSnapshot.docs) {
      allEvents.add(doc.data() as Map<String, dynamic>);
    }
    for (var doc in joinedEventsSnapshot.docs) {
      allEvents.add(doc.data() as Map<String, dynamic>);
    }

    return allEvents;
  }
}
