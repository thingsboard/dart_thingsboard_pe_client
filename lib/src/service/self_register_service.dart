import 'dart:convert';

import 'package:dio/dio.dart';

import '../model/self_register_models.dart';

import '../http/http_utils.dart';
import '../thingsboard_client_base.dart';

class SelfRegistrationService {
  final ThingsboardClient _tbClient;

  factory SelfRegistrationService(ThingsboardClient tbClient) {
    return SelfRegistrationService._internal(tbClient);
  }

  SelfRegistrationService._internal(this._tbClient);

  Future<SelfRegistrationParams?> getSelfRegistrationParams(
      {RequestConfig? requestConfig}) async {
    return nullIfNotFound(
      (RequestConfig requestConfig) async {
        var response = await _tbClient.get<Map<String, dynamic>>(
            '/api/selfRegistration/selfRegistrationParams',
            options: defaultHttpOptionsFromConfig(requestConfig));
        return response.data != null
            ? SelfRegistrationParams.fromJson(response.data!)
            : null;
      },
      requestConfig: requestConfig,
    );
  }

  Future<SelfRegistrationParams> saveSelfRegistrationParams(
      SelfRegistrationParams selfRegistrationParams,
      {RequestConfig? requestConfig}) async {
    var response = await _tbClient.post<Map<String, dynamic>>(
        '/api/selfRegistration/selfRegistrationParams',
        data: jsonEncode(selfRegistrationParams),
        options: defaultHttpOptionsFromConfig(requestConfig));
    return SelfRegistrationParams.fromJson(response.data!);
  }

  Future<SignUpSelfRegistrationParams?> getSignUpSelfRegistrationParams(
      {String? pkgName, RequestConfig? requestConfig}) async {
    return nullIfNotFound(
      (RequestConfig requestConfig) async {
        var queryParams = <String, dynamic>{};
        if (pkgName != null) {
          queryParams['pkgName'] = pkgName;
        }
        var response = await _tbClient.get<Map<String, dynamic>>(
            '/api/noauth/selfRegistration/signUpSelfRegistrationParams',
            queryParameters: queryParams,
            options: defaultHttpOptionsFromConfig(requestConfig));
        return response.data != null
            ? SignUpSelfRegistrationParams.fromJson(response.data!)
            : null;
      },
      requestConfig: requestConfig,
    );
  }

  Future<String> getPrivacyPolicy({RequestConfig? requestConfig}) async {
    var options = defaultHttpOptionsFromConfig(requestConfig);
    options.responseType = ResponseType.plain;
    var response = await _tbClient.get<String>(
        '/api/noauth/selfRegistration/privacyPolicy',
        options: options);
    return response.data!;
  }
}
