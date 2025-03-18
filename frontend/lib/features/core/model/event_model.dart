import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  final String? id;
  final String email;
  final String name;
  final String password;
  final String profilePicture;

 EventModel({
    this.id,
    required this.email,
    required this.name,
    required this.password,
    required this.profilePicture,
  });

  static EventModel empty() {
    return EventModel(
      email: '',
      name: '',
      password: '',
      profilePicture: '',
    );
  }
  
  toJson() {
    return {
      "Id": id,
      "FullName": name,
      "Email": email,
      "Password" : password,
      'Profile Picture': profilePicture,
    };
  }

  factory EventModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return EventModel(
      id: snapshot.id,
      email: data['Email'],
      name:data['FullName'],
      password: data['Password'],
      profilePicture: data['Profile Picture'],
    );
  }
}