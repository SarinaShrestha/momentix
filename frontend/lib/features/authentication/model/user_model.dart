import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String email;
  final String name;
  final String password;
  final String profilePicture;

  UserModel({
    this.id,
    required this.email,
    required this.name,
    required this.password,
    required this.profilePicture,
  });

  toJson() {
    return {
      "Id": id,
      "FullName": name,
      "Email": email,
      "Password" : password,
      'Profile Picture': profilePicture,
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return UserModel(
      id: snapshot.id,
      email: data['Email'],
      name:data['FullName'],
      password: data['Password'],
      profilePicture: data['Profile Picture'],
    );
  }
}