class SignUpRequest {
  String firstName;
  String lastName;
  String email;
  String password;
  String recaptchaResponse;

  SignUpRequest({required this.firstName, required this.lastName, required this.email, required this.password, required this.recaptchaResponse});

  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'password': password,
    'recaptchaResponse': recaptchaResponse
  };

  @override
  String toString() {
    return 'SignUpRequest{firstName: $firstName, lastName: $lastName, email: $email, password: $password, recaptchaResponse: $recaptchaResponse}';
  }
}

enum SignUpResult {
  SUCCESS,
  INACTIVE_USER_EXISTS
}

SignUpResult signUpResultFromString(String value) {
  return SignUpResult.values.firstWhere((e)=>e.toString().split('.')[1].toUpperCase()==value.toUpperCase());
}
