import 'dart:convert';

import '../thingsboard_client_base.dart';
import '../http/http_utils.dart';
import '../model/model.dart';

PageData<Asset> parseAssetPageData(Map<String, dynamic> json) {
  return PageData.fromJson(json, (json) => Asset.fromJson(json));
}

class AssetService {
  final ThingsboardClient _tbClient;

  factory AssetService(ThingsboardClient tbClient) {
    return AssetService._internal(tbClient);
  }

  AssetService._internal(this._tbClient);

  Future<Asset?> getAsset(String assetId,
      {RequestConfig? requestConfig}) async {
    return nullIfNotFound(
      (RequestConfig requestConfig) async {
        var response = await _tbClient.get<Map<String, dynamic>>(
            '/api/asset/$assetId',
            options: defaultHttpOptionsFromConfig(requestConfig));
        return response.data != null ? Asset.fromJson(response.data!) : null;
      },
      requestConfig: requestConfig,
    );
  }

  Future<Asset> saveAsset(Asset asset, {RequestConfig? requestConfig}) async {
    var response = await _tbClient.post<Map<String, dynamic>>('/api/asset',
        data: jsonEncode(asset),
        options: defaultHttpOptionsFromConfig(requestConfig));
    return Asset.fromJson(response.data!);
  }

  Future<void> deleteAsset(String assetId,
      {RequestConfig? requestConfig}) async {
    await _tbClient.delete('/api/asset/$assetId',
        options: defaultHttpOptionsFromConfig(requestConfig));
  }

  Future<PageData<Asset>> getTenantAssets(PageLink pageLink,
      {String type = '', RequestConfig? requestConfig}) async {
    var queryParams = pageLink.toQueryParameters();
    queryParams['type'] = type;
    var response = await _tbClient.get<Map<String, dynamic>>(
        '/api/tenant/assets',
        queryParameters: queryParams,
        options: defaultHttpOptionsFromConfig(requestConfig));
    return _tbClient.compute(parseAssetPageData, response.data!);
  }

  Future<Asset?> getTenantAsset(String assetName,
      {RequestConfig? requestConfig}) async {
    return nullIfNotFound(
      (RequestConfig requestConfig) async {
        var response = await _tbClient.get<Map<String, dynamic>>(
            '/api/tenant/assets',
            queryParameters: {'assetName': assetName},
            options: defaultHttpOptionsFromConfig(requestConfig));
        return response.data != null ? Asset.fromJson(response.data!) : null;
      },
      requestConfig: requestConfig,
    );
  }

  Future<PageData<Asset>> getCustomerAssets(
      String customerId, PageLink pageLink,
      {String type = '', RequestConfig? requestConfig}) async {
    var queryParams = pageLink.toQueryParameters();
    queryParams['type'] = type;
    var response = await _tbClient.get<Map<String, dynamic>>(
        '/api/customer/$customerId/assets',
        queryParameters: queryParams,
        options: defaultHttpOptionsFromConfig(requestConfig));
    return _tbClient.compute(parseAssetPageData, response.data!);
  }

  Future<PageData<Asset>> getUserAssets(PageLink pageLink,
      {String type = '', RequestConfig? requestConfig}) async {
    var queryParams = pageLink.toQueryParameters();
    queryParams['type'] = type;
    var response = await _tbClient.get<Map<String, dynamic>>('/api/user/assets',
        queryParameters: queryParams,
        options: defaultHttpOptionsFromConfig(requestConfig));
    return _tbClient.compute(parseAssetPageData, response.data!);
  }

  Future<List<Asset>> getAssetsByIds(List<String> assetIds,
      {RequestConfig? requestConfig}) async {
    var response = await _tbClient.get<List<dynamic>>('/api/assets',
        queryParameters: {'assetIds': assetIds.join(',')},
        options: defaultHttpOptionsFromConfig(requestConfig));
    return response.data!.map((e) => Asset.fromJson(e)).toList();
  }

  Future<List<Asset>> findByQuery(AssetSearchQuery query,
      {RequestConfig? requestConfig}) async {
    var response = await _tbClient.post<List<dynamic>>('/api/assets',
        data: jsonEncode(query),
        options: defaultHttpOptionsFromConfig(requestConfig));
    return response.data!.map((e) => Asset.fromJson(e)).toList();
  }

  Future<PageData<Asset>> getAssetsByEntityGroupId(
      String entityGroupId, PageLink pageLink,
      {RequestConfig? requestConfig}) async {
    var response = await _tbClient.get<Map<String, dynamic>>(
        '/api/entityGroup/$entityGroupId/assets',
        queryParameters: pageLink.toQueryParameters(),
        options: defaultHttpOptionsFromConfig(requestConfig));
    return _tbClient.compute(parseAssetPageData, response.data!);
  }

  Future<List<EntitySubtype>> getAssetTypes(
      {RequestConfig? requestConfig}) async {
    var response = await _tbClient.get<List<dynamic>>('/api/asset/types',
        options: defaultHttpOptionsFromConfig(requestConfig));
    return response.data!.map((e) => EntitySubtype.fromJson(e)).toList();
  }
}
