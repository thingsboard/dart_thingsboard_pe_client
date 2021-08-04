class CustomMenuItem {
  String name;
  String? iconUrl;
  String? materialIcon;
  String? iframeUrl;
  String? dashboardId;
  bool? hideDashboardToolbar;
  bool? setAccessToken;
  List<CustomMenuItem>? childMenuItems;

  CustomMenuItem(this.name,
      {this.iconUrl,
      this.materialIcon,
      this.iframeUrl,
      this.dashboardId,
      this.hideDashboardToolbar,
      this.setAccessToken,
      this.childMenuItems});

  CustomMenuItem.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        iconUrl = json['iconUrl'],
        materialIcon = json['materialIcon'],
        iframeUrl = json['iframeUrl'],
        dashboardId = json['dashboardId'],
        hideDashboardToolbar = json['hideDashboardToolbar'],
        setAccessToken = json['setAccessToken'],
        childMenuItems = json['childMenuItems'] != null
            ? (json['childMenuItems'] as List<dynamic>)
                .map((e) => CustomMenuItem.fromJson(e))
                .toList()
            : null;

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{'name': name};
    if (iconUrl != null) {
      json['iconUrl'] = iconUrl;
    }
    if (materialIcon != null) {
      json['materialIcon'] = materialIcon;
    }
    if (iframeUrl != null) {
      json['iframeUrl'] = iframeUrl;
    }
    if (dashboardId != null) {
      json['dashboardId'] = dashboardId;
    }
    if (hideDashboardToolbar != null) {
      json['hideDashboardToolbar'] = hideDashboardToolbar;
    }
    if (setAccessToken != null) {
      json['setAccessToken'] = setAccessToken;
    }
    if (childMenuItems != null) {
      json['childMenuItems'] = childMenuItems!.map((e) => e.toJson()).toList();
    }
    return json;
  }

  @override
  String toString() {
    return 'CustomMenuItem{name: $name, iconUrl: $iconUrl, materialIcon: $materialIcon, iframeUrl: $iframeUrl, dashboardId: $dashboardId, hideDashboardToolbar: $hideDashboardToolbar, setAccessToken: $setAccessToken, childMenuItems: $childMenuItems}';
  }
}

class CustomMenu {
  List<String>? disabledMenuItems;
  List<CustomMenuItem>? menuItems;

  CustomMenu({this.disabledMenuItems, this.menuItems});

  CustomMenu.fromJson(Map<String, dynamic> json)
      : disabledMenuItems = json['disabledMenuItems'],
        menuItems = json['menuItems'] != null
            ? (json['menuItems'] as List<dynamic>)
                .map((e) => CustomMenuItem.fromJson(e))
                .toList()
            : null;

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{};
    if (disabledMenuItems != null) {
      json['disabledMenuItems'] = disabledMenuItems;
    }
    if (menuItems != null) {
      json['menuItems'] = menuItems!.map((e) => e.toJson()).toList();
    }
    return json;
  }

  @override
  String toString() {
    return 'CustomMenu{disabledMenuItems: $disabledMenuItems, menuItems: $menuItems}';
  }
}
