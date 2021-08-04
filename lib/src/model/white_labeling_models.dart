import 'dart:math';

class Favicon {
  String? url;
  String? type;

  Favicon({this.url, this.type});

  Favicon.fromJson(Map<String, dynamic> json)
      : url = json['url'],
        type = json['type'];

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{};
    if (url != null) {
      json['url'] = url;
    }
    if (type != null) {
      json['type'] = type;
    }
    return json;
  }

  @override
  String toString() {
    return 'Favicon{url: ${url != null ? '[' + url!.substring(0, min(30, url!.length)) + '...]' : 'null'}, type: $type}';
  }
}

class Palette {
  String? type;
  String? extendsPalette;
  Map<String, String>? colors;

  Palette({required this.type, this.extendsPalette, this.colors});

  Palette.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        extendsPalette = json['extends'],
        colors = json['colors'] != null
            ? (json['colors'] as Map)
                .map((key, value) => MapEntry(key as String, value as String))
            : null;

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{'type': type};
    if (extendsPalette != null) {
      json['extends'] = extendsPalette;
    }
    if (colors != null) {
      json['colors'] = colors;
    }
    return json;
  }

  @override
  String toString() {
    return 'Palette{type: $type, extendsPalette: $extendsPalette, colors: $colors}';
  }
}

class PaletteSettings {
  Palette? primaryPalette;
  Palette? accentPalette;

  PaletteSettings({this.primaryPalette, this.accentPalette});

  PaletteSettings.fromJson(Map<String, dynamic> json)
      : primaryPalette = json['primaryPalette'] != null
            ? Palette.fromJson(json['primaryPalette'])
            : null,
        accentPalette = json['accentPalette'] != null
            ? Palette.fromJson(json['accentPalette'])
            : null;

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{};
    if (primaryPalette != null) {
      json['primaryPalette'] = primaryPalette!.toJson();
    }
    if (accentPalette != null) {
      json['accentPalette'] = accentPalette!.toJson();
    }
    return json;
  }

  @override
  String toString() {
    return 'PaletteSettings{primaryPalette: $primaryPalette, accentPalette: $accentPalette}';
  }
}

class WhiteLabelingParams {
  String? logoImageUrl;
  String? logoImageChecksum;
  int? logoImageHeight;
  String? appTitle;
  Favicon? favicon;
  String? faviconChecksum;
  PaletteSettings? paletteSettings;
  String? helpLinkBaseUrl;
  bool? enableHelpLinks;
  bool? showNameVersion;
  String? platformName;
  String? platformVersion;
  String? customCss;

  WhiteLabelingParams(
      {this.logoImageUrl,
      this.logoImageChecksum,
      this.logoImageHeight,
      this.appTitle,
      this.favicon,
      this.faviconChecksum,
      this.paletteSettings,
      this.helpLinkBaseUrl,
      this.enableHelpLinks,
      this.showNameVersion,
      this.platformName,
      this.platformVersion,
      this.customCss});

  WhiteLabelingParams.fromJson(Map<String, dynamic> json)
      : logoImageUrl = json['logoImageUrl'],
        logoImageChecksum = json['logoImageChecksum'],
        logoImageHeight = json['logoImageHeight'],
        appTitle = json['appTitle'],
        favicon =
            json['favicon'] != null ? Favicon.fromJson(json['favicon']) : null,
        faviconChecksum = json['faviconChecksum'],
        paletteSettings = json['paletteSettings'] != null
            ? PaletteSettings.fromJson(json['paletteSettings'])
            : null,
        helpLinkBaseUrl = json['helpLinkBaseUrl'],
        enableHelpLinks = json['enableHelpLinks'],
        showNameVersion = json['showNameVersion'],
        platformName = json['platformName'],
        platformVersion = json['platformVersion'],
        customCss = json['customCss'];

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{};
    if (logoImageUrl != null) {
      json['logoImageUrl'] = logoImageUrl;
    }
    if (logoImageHeight != null) {
      json['logoImageHeight'] = logoImageHeight;
    }
    if (appTitle != null) {
      json['appTitle'] = appTitle;
    }
    if (favicon != null) {
      json['favicon'] = favicon!.toJson();
    }
    if (paletteSettings != null) {
      json['paletteSettings'] = paletteSettings!.toJson();
    }
    if (helpLinkBaseUrl != null) {
      json['helpLinkBaseUrl'] = helpLinkBaseUrl;
    }
    if (enableHelpLinks != null) {
      json['enableHelpLinks'] = enableHelpLinks;
    }
    if (showNameVersion != null) {
      json['showNameVersion'] = showNameVersion;
    }
    if (platformName != null) {
      json['platformName'] = platformName;
    }
    if (platformVersion != null) {
      json['platformVersion'] = platformVersion;
    }
    if (customCss != null) {
      json['customCss'] = customCss;
    }
    return json;
  }

  @override
  String toString() {
    return 'WhiteLabelingParams{${whiteLabelingParamsString()}}';
  }

  String whiteLabelingParamsString([String? toStringBody]) {
    return 'logoImageUrl: ${logoImageUrl != null ? '[' + logoImageUrl!.substring(0, min(30, logoImageUrl!.length)) + '...]' : 'null'}, logoImageChecksum: $logoImageChecksum, logoImageHeight: $logoImageHeight, '
        'appTitle: $appTitle, favicon: $favicon, faviconChecksum: $faviconChecksum, paletteSettings: $paletteSettings, '
        'helpLinkBaseUrl: $helpLinkBaseUrl, enableHelpLinks: $enableHelpLinks, showNameVersion: $showNameVersion, '
        'platformName: $platformName, platformVersion: $platformVersion, customCss: $customCss${toStringBody != null ? ', ' + toStringBody : ''}';
  }
}

class LoginWhiteLabelingParams extends WhiteLabelingParams {
  String? pageBackgroundColor;
  bool? darkForeground;
  String? domainName;
  String? baseUrl;
  bool? prohibitDifferentUrl;
  String? adminSettingsId;
  bool? showNameBottom;

  LoginWhiteLabelingParams(
      {this.pageBackgroundColor,
      this.darkForeground,
      this.domainName,
      required this.baseUrl,
      this.prohibitDifferentUrl,
      this.showNameBottom,
      String? logoImageUrl,
      String? logoImageChecksum,
      int? logoImageHeight,
      String? appTitle,
      Favicon? favicon,
      String? faviconChecksum,
      PaletteSettings? paletteSettings,
      bool? showNameVersion,
      String? platformName,
      String? platformVersion,
      String? customCss})
      : super(
            logoImageUrl: logoImageUrl,
            logoImageChecksum: logoImageChecksum,
            logoImageHeight: logoImageHeight,
            appTitle: appTitle,
            favicon: favicon,
            faviconChecksum: faviconChecksum,
            paletteSettings: paletteSettings,
            showNameVersion: showNameVersion,
            platformName: platformName,
            platformVersion: platformVersion,
            customCss: customCss);

  LoginWhiteLabelingParams.fromJson(Map<String, dynamic> json)
      : pageBackgroundColor = json['pageBackgroundColor'],
        darkForeground = json['darkForeground'],
        domainName = json['domainName'],
        baseUrl = json['baseUrl'],
        prohibitDifferentUrl = json['prohibitDifferentUrl'],
        adminSettingsId = json['adminSettingsId'],
        showNameBottom = json['showNameBottom'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    if (pageBackgroundColor != null) {
      json['pageBackgroundColor'] = pageBackgroundColor;
    }
    if (darkForeground != null) {
      json['darkForeground'] = darkForeground;
    }
    if (domainName != null) {
      json['domainName'] = domainName;
    }
    json['baseUrl'] = baseUrl;
    if (prohibitDifferentUrl != null) {
      json['prohibitDifferentUrl'] = prohibitDifferentUrl;
    }
    if (adminSettingsId != null) {
      json['adminSettingsId'] = adminSettingsId;
    }
    if (showNameBottom != null) {
      json['showNameBottom'] = showNameBottom;
    }
    return json;
  }

  @override
  String toString() {
    return 'LoginWhiteLabelingParams{${whiteLabelingParamsString('pageBackgroundColor: $pageBackgroundColor, darkForeground: $darkForeground, '
        'domainName: $domainName, baseUrl: $baseUrl, prohibitDifferentUrl: $prohibitDifferentUrl, adminSettingsId: $adminSettingsId, showNameBottom: $showNameBottom')}}';
  }
}
