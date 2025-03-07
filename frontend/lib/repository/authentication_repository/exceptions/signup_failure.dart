import 'package:frontend/utils/text_strings.dart';

class SignUpFailure {
  final String message;

  const SignUpFailure([this.message = signUpError]);

  factory SignUpFailure.code(String code) {
    switch(code){
      case 'emptyName' :
        return const SignUpFailure(noName);

      case 'invalidName' : 
        return const SignUpFailure(invalidName);

      case 'emptyEmail' : 
        return const SignUpFailure(noEmail);

      case 'emptyPassword' :
        return const SignUpFailure(noPassword);

      case 'emptyConfirmPassword' :
        return const SignUpFailure(noConfirmPassword);

      case 'passwordMismatch' :
        return const SignUpFailure(passwordMismatch);

      case 'userExists' : 
        return const SignUpFailure(userExists);

      case 'invalidEmail' : 
        return const SignUpFailure(invalidEmail);

      case 'weakPassword' : 
        return const SignUpFailure(weakPassword);
        
      default: 
        return const SignUpFailure();
    }
  }
}