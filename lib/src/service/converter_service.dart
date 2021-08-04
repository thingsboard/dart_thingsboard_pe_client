import 'dart:convert';

import '../model/page/page_link.dart';
import '../http/http_utils.dart';
import '../thingsboard_client_base.dart';
import '../model/converter_models.dart';
import '../model/page/page_data.dart';

PageData<Converter> parseConverterPageData(Map<String, dynamic> json) {
  return PageData.fromJson(json, (json) => Converter.fromJson(json));
}

class ConverterService {
  final ThingsboardClient _tbClient;

  factory ConverterService(ThingsboardClient tbClient) {
    return ConverterService._internal(tbClient);
  }

  ConverterService._internal(this._tbClient);

  Future<Converter?> getConverter(String converterId,
      {RequestConfig? requestConfig}) async {
    return nullIfNotFound(
      (RequestConfig requestConfig) async {
        var response = await _tbClient.get<Map<String, dynamic>>(
            '/api/converter/$converterId',
            options: defaultHttpOptionsFromConfig(requestConfig));
        return response.data != null
            ? Converter.fromJson(response.data!)
            : null;
      },
      requestConfig: requestConfig,
    );
  }

  Future<Converter> saveConverter(Converter converter,
      {RequestConfig? requestConfig}) async {
    var response = await _tbClient.post<Map<String, dynamic>>('/api/converter',
        data: jsonEncode(converter),
        options: defaultHttpOptionsFromConfig(requestConfig));
    return Converter.fromJson(response.data!);
  }

  Future<PageData<Converter>> getConverters(PageLink pageLink,
      {RequestConfig? requestConfig}) async {
    var response = await _tbClient.get<Map<String, dynamic>>('/api/converters',
        queryParameters: pageLink.toQueryParameters(),
        options: defaultHttpOptionsFromConfig(requestConfig));
    return _tbClient.compute(parseConverterPageData, response.data!);
  }

  Future<void> deleteConverter(String converterId,
      {RequestConfig? requestConfig}) async {
    await _tbClient.delete('/api/converter/$converterId',
        options: defaultHttpOptionsFromConfig(requestConfig));
  }

  Future<List<Converter>> getConvertersByIds(List<String> converterIds,
      {RequestConfig? requestConfig}) async {
    var response = await _tbClient.get<List<dynamic>>('/api/converters',
        queryParameters: {'converterIds': converterIds.join(',')},
        options: defaultHttpOptionsFromConfig(requestConfig));
    return response.data!.map((e) => Converter.fromJson(e)).toList();
  }

  Future<TestConverterResult> testUpLink(TestUpLinkInputParams inputParams,
      {RequestConfig? requestConfig}) async {
    var response = await _tbClient.post<Map<String, dynamic>>(
        '/api/converter/testUpLink',
        data: jsonEncode(inputParams),
        options: defaultHttpOptionsFromConfig(requestConfig));
    return TestConverterResult.fromJson(response.data!);
  }

  Future<TestConverterResult> testDownLink(TestDownLinkInputParams inputParams,
      {RequestConfig? requestConfig}) async {
    var response = await _tbClient.post<Map<String, dynamic>>(
        '/api/converter/testDownLink',
        data: jsonEncode(inputParams),
        options: defaultHttpOptionsFromConfig(requestConfig));
    return TestConverterResult.fromJson(response.data!);
  }

  Future<ConverterDebugInput?> getLatestConverterDebugInput(String converterId,
      {RequestConfig? requestConfig}) async {
    return nullIfNotFound(
      (RequestConfig requestConfig) async {
        var response = await _tbClient.get<Map<String, dynamic>>(
            '/api/converter/$converterId/debugIn',
            options: defaultHttpOptionsFromConfig(requestConfig));
        return response.data != null
            ? ConverterDebugInput.fromJson(response.data!)
            : null;
      },
      requestConfig: requestConfig,
    );
  }
}
