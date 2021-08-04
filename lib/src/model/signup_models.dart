class SignUpRequest {
  String firstName;
  String lastName;
  String email;
  String password;
  String recaptchaResponse;
  String? pkgName;
  String? appSecret;

  SignUpRequest(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      required this.recaptchaResponse,
      this.pkgName,
      this.appSecret});

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'recaptchaResponse': recaptchaResponse
    };
    if (pkgName != null) {
      json['pkgName'] = pkgName;
    }
    if (appSecret != null) {
      json['appSecret'] = appSecret;
    }
    return json;
  }

  @override
  String toString() {
    return 'SignUpRequest{firstName: $firstName, lastName: $lastName, email: $email, password: $password, recaptchaResponse: $recaptchaResponse, pkgName: $pkgName, appSecret: $appSecret}';
  }
}

enum SignUpResult { SUCCESS, INACTIVE_USER_EXISTS }

SignUpResult signUpResultFromString(String value) {
  return SignUpResult.values.firstWhere(
      (e) => e.toString().split('.')[1].toUpperCase() == value.toUpperCase());
}
