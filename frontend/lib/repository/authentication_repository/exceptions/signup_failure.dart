class SignUpFailure {
  final String message;

  const SignUpFailure([this.message = "An error occurred while signing up"]);

  factory SignUpFailure.code(String code) {
    switch(code){
      case 'emptyName' :
        return const SignUpFailure("Name cannot be empty.");

      case 'invalidName' : 
        return const SignUpFailure("Name is invalid.");

      case 'emptyEmail' : 
        return const SignUpFailure("Email cannot be empty.");

      case 'emptyPassword' :
        return const SignUpFailure("Password cannot be empty.");

      case 'emptyConfirmPassword' :
        return const SignUpFailure("Confirm password cannot be empty.");

      case 'passwordMismatch' :
        return const SignUpFailure("Passwords do not match.");

      case 'userExists' : 
        return const SignUpFailure("User with this email already exists.");

      case 'invalidEmail' : 
        return const SignUpFailure("The entered email is invalid.");

      case 'weakPassword' : 
        return const SignUpFailure("The password is too weak.");
        
      case 'userDisabled' : 
        return const SignUpFailure("The user has been disabled.");
      default: 
        return const SignUpFailure();
    }
  }
}