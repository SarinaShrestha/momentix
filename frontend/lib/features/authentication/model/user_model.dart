class UserModel {
  final String? id;
  final String email;
  final String name;
  final String password;


  UserModel({
    this.id,
    required this.email,
    required this.name,
    required this.password,
  });

  toJson() {
    return {
      "Id": id,
      "FullName": name,
      "Email": email,
      "Password" : password,
    };
  }
}