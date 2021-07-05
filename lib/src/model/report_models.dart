class ReportParams {
  final String? type;
  final String? state;
  final Map<String, dynamic>? timewindow;
  final String? timezone;

  ReportParams({this.type, this.state, this.timewindow, this.timezone});

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{};
    if (type != null) {
      json['type'] = type;
    }
    if (state != null) {
      json['state'] = state;
    }
    if (timewindow != null) {
      json['timewindow'] = timewindow;
    }
    if (timezone != null) {
      json['timezone'] = timezone;
    }
    return json;
  }
}

class ReportConfig extends ReportParams {
  final String baseUrl;
  final String dashboardId;
  final bool useDashboardTimewindow;
  final String namePattern;
  final bool? useCurrentUserCredentials;
  final String userId;

  ReportConfig(
      {required this.baseUrl,
      required this.dashboardId,
      required this.useDashboardTimewindow,
      required this.namePattern,
      required this.userId,
      this.useCurrentUserCredentials,
      String? type,
      String? state,
      Map<String, dynamic>? timewindow,
      String? timezone})
      : super(
            type: type,
            state: state,
            timewindow: timewindow,
            timezone: timezone);

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    json['baseUrl'] = baseUrl;
    json['dashboardId'] = dashboardId;
    json['useDashboardTimewindow'] = useDashboardTimewindow;
    json['namePattern'] = namePattern;
    json['userId'] = userId;
    if (useCurrentUserCredentials != null) {
      json['useCurrentUserCredentials'] = useCurrentUserCredentials;
    }
    return json;
  }
}
