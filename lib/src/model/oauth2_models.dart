class OAuth2ClientInfo {

  final String name;
  final String? icon;
  final String url;

  OAuth2ClientInfo.fromJson(Map<String, dynamic> json):
        name = json['name'],
        icon =  json['icon'],
        url =  json['url'];

}