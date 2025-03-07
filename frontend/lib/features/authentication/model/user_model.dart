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
}