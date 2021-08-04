import 'package:dio/dio.dart';
import '../model/page/page_link.dart';
import '../http/http_utils.dart';
import '../model/page/page_data.dart';
import '../model/blob_entity_models.dart';
import '../thingsboard_client_base.dart';

PageData<BlobEntityInfo> parseBlobEntityInfoPageData(
    Map<String, dynamic> json) {
  return PageData.fromJson(json, (json) => BlobEntityInfo.fromJson(json));
}

class BlobEntityService {
  final ThingsboardClient _tbClient;

  factory BlobEntityService(ThingsboardClient tbClient) {
    return BlobEntityService._internal(tbClient);
  }

  BlobEntityService._internal(this._tbClient);

  Future<BlobEntityWithCustomerInfo?> getBlobEntityInfo(String blobEntityInfoId,
      {RequestConfig? requestConfig}) async {
    return nullIfNotFound(
      (RequestConfig requestConfig) async {
        var response = await _tbClient.get<Map<String, dynamic>>(
            '/api/blobEntity/info/$blobEntityInfoId',
            options: defaultHttpOptionsFromConfig(requestConfig));
        return response.data != null
            ? BlobEntityWithCustomerInfo.fromJson(response.data!)
            : null;
      },
      requestConfig: requestConfig,
    );
  }

  Future<ResponseBody?> downloadBlobEntity(String blobEntityId,
      {RequestConfig? requestConfig}) async {
    return nullIfNotFound(
      (RequestConfig requestConfig) async {
        var options = defaultHttpOptionsFromConfig(requestConfig);
        options.responseType = ResponseType.stream;
        var response = await _tbClient.get<ResponseBody>(
            '/api/blobEntity/$blobEntityId/download',
            options: options);
        return response.data;
      },
      requestConfig: requestConfig,
    );
  }

  Future<void> deleteBlobEntity(String blobEntityId,
      {RequestConfig? requestConfig}) async {
    await _tbClient.delete('/api/blobEntity/$blobEntityId',
        options: defaultHttpOptionsFromConfig(requestConfig));
  }

  Future<PageData<BlobEntityInfo>> getBlobEntities(TimePageLink timePageLink,
      {String type = '', RequestConfig? requestConfig}) async {
    var queryParams = timePageLink.toQueryParameters();
    queryParams['type'] = type;
    var response = await _tbClient.get<Map<String, dynamic>>(
        '/api/blobEntities',
        queryParameters: queryParams,
        options: defaultHttpOptionsFromConfig(requestConfig));
    return _tbClient.compute(parseBlobEntityInfoPageData, response.data!);
  }

  Future<List<BlobEntityInfo>> getBlobEntitiesByIds(List<String> blobEntityIds,
      {RequestConfig? requestConfig}) async {
    var response = await _tbClient.get<List<dynamic>>('/api/blobEntities',
        queryParameters: {'blobEntityIds': blobEntityIds.join(',')},
        options: defaultHttpOptionsFromConfig(requestConfig));
    return response.data!.map((e) => BlobEntityInfo.fromJson(e)).toList();
  }
}
