import 'group_permission_models.dart';

class SignUpSelfRegistrationParams {
  String? signUpTextMessage;
  String? captchaSiteKey;

  SignUpSelfRegistrationParams({this.signUpTextMessage, this.captchaSiteKey});

  SignUpSelfRegistrationParams.fromJson(Map<String, dynamic> json)
      : signUpTextMessage = json['signUpTextMessage'],
        captchaSiteKey = json['captchaSiteKey'];

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{};
    if (signUpTextMessage != null) {
      json['signUpTextMessage'] = signUpTextMessage;
    }
    if (captchaSiteKey != null) {
      json['captchaSiteKey'] = captchaSiteKey;
    }
    return json;
  }

  @override
  String toString() {
    return 'SignUpSelfRegistrationParams{${signUpSelfRegistrationParamsString()}}';
  }

  String signUpSelfRegistrationParamsString([String? toStringBody]) {
    return 'signUpTextMessage: $signUpTextMessage, captchaSiteKey: $captchaSiteKey${toStringBody != null ? ', ' + toStringBody : ''}';
  }
}

class SelfRegistrationParams extends SignUpSelfRegistrationParams {
  String? adminSettingsId;
  String? domainName;
  String? captchaSecretKey;
  String? privacyPolicy;
  String? notificationEmail;
  String? defaultDashboardId;
  bool? defaultDashboardFullscreen;
  List<GroupPermission>? permissions;
  String? pkgName;
  String? appSecret;
  String? appScheme;
  String? appHost;

  SelfRegistrationParams(
      {String? signUpTextMessage,
      String? captchaSiteKey,
      this.adminSettingsId,
      this.domainName,
      this.captchaSecretKey,
      this.privacyPolicy,
      this.notificationEmail,
      this.defaultDashboardId,
      this.defaultDashboardFullscreen,
      this.permissions,
      this.pkgName,
      this.appSecret,
      this.appScheme,
      this.appHost})
      : super(
            signUpTextMessage: signUpTextMessage,
            captchaSiteKey: captchaSiteKey);

  SelfRegistrationParams.fromJson(Map<String, dynamic> json)
      : adminSettingsId = json['adminSettingsId'],
        domainName = json['domainName'],
        captchaSecretKey = json['captchaSecretKey'],
        privacyPolicy = json['privacyPolicy'],
        notificationEmail = json['notificationEmail'],
        defaultDashboardId = json['defaultDashboardId'],
        defaultDashboardFullscreen = json['defaultDashboardFullscreen'],
        permissions = json['permissions'] != null
            ? (json['permissions'] as List<dynamic>)
                .map((e) => GroupPermission.fromJson(e))
                .toList()
            : null,
        pkgName = json['pkgName'],
        appSecret = json['appSecret'],
        appScheme = json['appScheme'],
        appHost = json['appHost'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    if (adminSettingsId != null) {
      json['adminSettingsId'] = adminSettingsId;
    }
    if (domainName != null) {
      json['domainName'] = domainName;
    }
    if (captchaSecretKey != null) {
      json['captchaSecretKey'] = captchaSecretKey;
    }
    if (privacyPolicy != null) {
      json['privacyPolicy'] = privacyPolicy;
    }
    if (notificationEmail != null) {
      json['notificationEmail'] = notificationEmail;
    }
    if (defaultDashboardId != null) {
      json['defaultDashboardId'] = defaultDashboardId;
    }
    if (defaultDashboardFullscreen != null) {
      json['defaultDashboardFullscreen'] = defaultDashboardFullscreen;
    }
    if (permissions != null) {
      json['permissions'] = permissions!.map((e) => e.toJson()).toList();
    }
    if (pkgName != null) {
      json['pkgName'] = pkgName;
    }
    if (pkgName != null) {
      json['pkgName'] = pkgName;
    }
    if (appSecret != null) {
      json['appSecret'] = appSecret;
    }
    if (appScheme != null) {
      json['appScheme'] = appScheme;
    }
    if (appHost != null) {
      json['appHost'] = appHost;
    }
    return json;
  }

  @override
  String toString() {
    return 'SelfRegistrationParams{${signUpSelfRegistrationParamsString('adminSettingsId: $adminSettingsId, domainName: $domainName, captchaSecretKey: $captchaSecretKey, '
        'privacyPolicy: $privacyPolicy, notificationEmail: $notificationEmail, defaultDashboardId: $defaultDashboardId, '
        'defaultDashboardFullscreen: $defaultDashboardFullscreen, permissions: $permissions, pkgName: $pkgName, appSecret: $appSecret, appScheme: $appScheme, appHost: $appHost')}}';
  }
}
