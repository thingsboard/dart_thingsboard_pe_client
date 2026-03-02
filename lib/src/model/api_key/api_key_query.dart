import 'package:thingsboard_pe_client/thingsboard_client.dart';
class ApiKeyQuery {
  final String userId;
  final PageLink pageLink;

  ApiKeyQuery({required this.userId, required this.pageLink});
}
