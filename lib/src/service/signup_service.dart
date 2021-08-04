import 'dart:convert';
import 'package:dio/dio.dart';
import '../model/login_models.dart';

import '../model/signup_models.dart';
import '../http/http_utils.dart';
import '../thingsboard_client_base.dart';

class SignupService {
  final ThingsboardClient _tbClient;

  factory SignupService(ThingsboardClient tbClient) {
    return SignupService._internal(tbClient);
  }

  SignupService._internal(this._tbClient);

  Future<SignUpResult> signup(SignUpRequest signUpRequest,
      {RequestConfig? requestConfig}) async {
    var options = defaultHttpOptionsFromConfig(requestConfig);
    options.responseType = ResponseType.plain;
    var response = await _tbClient.post<String>('/api/noauth/signup',
        data: jsonEncode(signUpRequest), options: options);
    return signUpResultFromString(jsonDecode(response.data!));
  }

  Future<LoginResponse?> acceptPrivacyPolicy(
      {RequestConfig? requestConfig}) async {
    return nullIfNotFound(
      (RequestConfig requestConfig) async {
        var response = await _tbClient.post<Map<String, dynamic>>(
            '/api/signup/acceptPrivacyPolicy',
            options: defaultHttpOptionsFromConfig(requestConfig));
        return response.data != null
            ? LoginResponse.fromJson(response.data!)
            : null;
      },
      requestConfig: requestConfig,
    );
  }

  Future<bool> privacyPolicyAccepted({RequestConfig? requestConfig}) async {
    var response = await _tbClient.get<bool>(
        '/api/signup/privacyPolicyAccepted',
        options: defaultHttpOptionsFromConfig(requestConfig));
    return response.data!;
  }

  Future<void> resendEmailActivation(String email,
      {String? pkgName, RequestConfig? requestConfig}) async {
    var queryParams = <String, dynamic>{'email': email};
    if (pkgName != null) {
      queryParams['pkgName'] = pkgName;
    }
    await _tbClient.post('/api/noauth/resendEmailActivation',
        queryParameters: queryParams,
        options: defaultHttpOptionsFromConfig(requestConfig));
  }

  Future<Response<String>> activateEmail(String emailCode,
      {String? pkgName, RequestConfig? requestConfig}) async {
    var queryParams = <String, dynamic>{'emailCode': emailCode};
    if (pkgName != null) {
      queryParams['pkgName'] = pkgName;
    }
    var options = defaultHttpOptionsFromConfig(requestConfig);
    options.responseType = ResponseType.plain;
    var response = await _tbClient.get<String>('/api/noauth/activateEmail',
        queryParameters: queryParams, options: options);
    return response;
  }

  Future<LoginResponse?> activateUserByEmailCode(String emailCode,
      {String? pkgName, RequestConfig? requestConfig}) async {
    return nullIfNotFound(
      (RequestConfig requestConfig) async {
        var queryParams = <String, dynamic>{'emailCode': emailCode};
        if (pkgName != null) {
          queryParams['pkgName'] = pkgName;
        }
        var response = await _tbClient.post<Map<String, dynamic>>(
            '/api/noauth/activateByEmailCode',
            queryParameters: queryParams,
            options: defaultHttpOptionsFromConfig(requestConfig));
        return response.data != null
            ? LoginResponse.fromJson(response.data!)
            : null;
      },
      requestConfig: requestConfig,
    );
  }
}
