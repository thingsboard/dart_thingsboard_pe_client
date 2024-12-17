import 'package:thingsboard_pe_client/src/model/model.dart';

enum SignUpFieldsId {
  email,
  password,
  repeat_password,
  first_name,
  last_name,
  phone,
  country,
  city,
  state,
  zip,
  address,
  address2,
  undefined,
}

SignUpFieldsId signUpFieldsIdFromString(String? value) {
  return SignUpFieldsId.values.firstWhere(
    (e) => e.toString().split('.')[1].toUpperCase() == value?.toUpperCase(),
    orElse: () => SignUpFieldsId.undefined,
  );
}

extension SignUpFieldsIdToString on SignUpFieldsId {
  String toShortString() {
    return toString().split('.').last.toUpperCase();
  }
}

class SignUpField {
  const SignUpField({
    required this.id,
    required this.label,
    required this.required,
  });

  final SignUpFieldsId id;
  final String label;
  final bool required;

  factory SignUpField.fromJson(Map<String, dynamic> json) {
    return SignUpField(
      id: signUpFieldsIdFromString(json['id']),
      label: json['label'],
      required: json['required'],
    );
  }
}

class MobileSignUpRequest {
  MobileSignUpRequest({
    required this.fields,
    required this.recaptchaResponse,
    required this.pkgName,
    required this.platform,
    required this.appSecret,
  });

  final Map<SignUpFieldsId, String> fields;
  String recaptchaResponse;
  String pkgName;
  PlatformType platform;
  String appSecret;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'recaptchaResponse': recaptchaResponse,
      'pkgName': pkgName,
      'platform': platform.toShortString(),
      'appSecret': appSecret,
      'fields': fields.map((k, v) => MapEntry(k.toShortString(), v)),
    };

    return json;
  }
}
