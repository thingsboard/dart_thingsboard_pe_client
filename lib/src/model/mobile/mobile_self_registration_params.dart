import 'package:thingsboard_pe_client/src/model/mobile/mobile_models.dart';

class MobileSelfRegistrationParams {
  const MobileSelfRegistrationParams({
    required this.title,
    required this.recaptcha,
    required this.fields,
    required this.showPrivacyPolicy,
    required this.showTermsOfUse,
  });

  final String? title;
  final RecaptchaModel recaptcha;
  final List<SignUpField> fields;
  final bool showPrivacyPolicy;
  final bool showTermsOfUse;

  factory MobileSelfRegistrationParams.fromJson(Map<String, dynamic> json) {
    return MobileSelfRegistrationParams(
      title: json['title'],
      recaptcha: RecaptchaModel.fromJson(json['captcha']),
      fields: json['fields']
          .map<SignUpField>((e) => SignUpField.fromJson(e))
          .toList(),
      showPrivacyPolicy: json['showPrivacyPolicy'],
      showTermsOfUse: json['showTermsOfUse'],
    );
  }
}
