class CustomTranslation {
  Map<String, String>? translationMap;

  CustomTranslation(this.translationMap);

  CustomTranslation.fromJson(Map<String, dynamic> json)
      : translationMap = json['translationMap'];

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{};
    if (translationMap != null) {
      json['translationMap'] = translationMap;
    }
    return json;
  }

  @override
  String toString() {
    return 'CustomTranslation{translationMap: $translationMap}';
  }
}
