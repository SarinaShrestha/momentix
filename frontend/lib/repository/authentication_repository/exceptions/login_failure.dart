import 'package:frontend/utils/text_strings.dart';

class LoginFailure {
  final String message;

  const LoginFailure([this.message = "An unknown error occurred."]);

  // Create an exception from a Firebase error code.
  factory LoginFailure.code(String code) {
    switch (code) {

      case 'invalidEmail':
        return const LoginFailure(invalidEmail);

      case 'userNotFound':
        return const LoginFailure('No user found with this email.');

      case 'wrongPassword':
        return const LoginFailure('Incorrect password. Please try again.');

      case 'emptyEmail':
        return const LoginFailure('Please enter your email address.');

      case 'emptyPassword':
        return const LoginFailure('Please enter your password.');

      default:
        return const LoginFailure('An unknown error occurred. Please try again.');
    }
  }
}
