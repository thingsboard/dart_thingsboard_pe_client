import 'dart:convert';

import '../thingsboard_client_base.dart';
import '../http/http_utils.dart';
import '../model/model.dart';

class CustomMenuService {
  final ThingsboardClient _tbClient;

  factory CustomMenuService(ThingsboardClient tbClient) {
    return CustomMenuService._internal(tbClient);
  }

  CustomMenuService._internal(this._tbClient);

  Future<CustomMenu?> getCustomMenu({RequestConfig? requestConfig}) async {
    return nullIfNotFound(
      (RequestConfig requestConfig) async {
        var response = await _tbClient.get<Map<String, dynamic>>(
            '/api/customMenu/customMenu',
            options: defaultHttpOptionsFromConfig(requestConfig));
        return response.data != null
            ? CustomMenu.fromJson(response.data!)
            : null;
      },
      requestConfig: requestConfig,
    );
  }

  Future<CustomMenu?> getCurrentCustomMenu(
      {RequestConfig? requestConfig}) async {
    return nullIfNotFound(
      (RequestConfig requestConfig) async {
        var response = await _tbClient.get<Map<String, dynamic>>(
            '/api/customMenu/currentCustomMenu',
            options: defaultHttpOptionsFromConfig(requestConfig));
        return response.data != null
            ? CustomMenu.fromJson(response.data!)
            : null;
      },
      requestConfig: requestConfig,
    );
  }

  Future<CustomMenu> saveCustomMenu(CustomMenu customMenu,
      {RequestConfig? requestConfig}) async {
    var response = await _tbClient.post<Map<String, dynamic>>(
        '/api/customMenu/customMenu',
        data: jsonEncode(customMenu),
        options: defaultHttpOptionsFromConfig(requestConfig));
    return CustomMenu.fromJson(response.data!);
  }
}
