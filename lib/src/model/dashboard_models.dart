import 'dart:math';

import 'customer_models.dart';
import 'base_data.dart';
import 'entity_type_models.dart';
import 'group_entity.dart';
import 'id/customer_id.dart';
import 'id/entity_id.dart';
import 'id/has_uuid.dart';
import 'id/tenant_id.dart';
import 'id/dashboard_id.dart';

class DashboardInfo extends BaseData<DashboardId>
    implements GroupEntity<DashboardId> {
  TenantId? tenantId;
  CustomerId? customerId;
  String title;
  String? image;
  Set<ShortCustomerInfo> assignedCustomers;
  bool? mobileHide;
  int? mobileOrder;

  DashboardInfo(this.title) : assignedCustomers = {};

  DashboardInfo.fromJson(Map<String, dynamic> json)
      : tenantId = TenantId.fromJson(json['tenantId']),
        customerId = json['customerId'] != null
            ? CustomerId.fromJson(json['customerId'])
            : null,
        title = json['title'],
        image = json['image'],
        assignedCustomers = json['assignedCustomers'] != null
            ? (json['assignedCustomers'] as List<dynamic>)
                .map((e) => ShortCustomerInfo.fromJson(e))
                .toSet()
            : {},
        mobileHide = json['mobileHide'],
        mobileOrder = json['mobileOrder'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    if (tenantId != null) {
      json['tenantId'] = tenantId!.toJson();
    }
    if (customerId != null) {
      json['customerId'] = customerId!.toJson();
    }
    json['title'] = title;
    if (image != null) {
      json['image'] = image;
    }
    json['assignedCustomers'] =
        assignedCustomers.map((e) => e.toJson()).toList();
    if (mobileHide != null) {
      json['mobileHide'] = mobileHide;
    }
    if (mobileOrder != null) {
      json['mobileOrder'] = mobileOrder;
    }
    return json;
  }

  @override
  String getName() {
    return title;
  }

  @override
  TenantId? getTenantId() {
    return tenantId;
  }

  @override
  CustomerId? getCustomerId() {
    return customerId;
  }

  @override
  EntityType getEntityType() {
    return EntityType.DASHBOARD;
  }

  @override
  EntityId? getOwnerId() {
    return customerId != null && !customerId!.isNullUid()
        ? customerId
        : tenantId;
  }

  @override
  void setOwnerId(EntityId entityId) {
    if (entityId.entityType == EntityType.CUSTOMER) {
      customerId = CustomerId(entityId.id!);
    } else {
      customerId = CustomerId(nullUuid);
    }
  }

  @override
  String toString() {
    return 'DashboardInfo{${dashboardInfoString()}}';
  }

  String dashboardInfoString([String? toStringBody]) {
    return '${baseDataString('tenantId: $tenantId, customerId: $customerId, title: $title, image: ${image != null ? '[' + image!.substring(0, min(30, image!.length)) + '...]' : 'null'}, '
        'mobileHide: $mobileHide, mobileOrder: $mobileOrder${toStringBody != null ? ', ' + toStringBody : ''}')}';
  }
}

class Dashboard extends DashboardInfo {
  Map<String, dynamic> configuration;

  Dashboard(String title)
      : configuration = {},
        super(title);

  Dashboard.fromJson(Map<String, dynamic> json)
      : configuration = json['configuration'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    json['configuration'] = configuration;
    return json;
  }

  @override
  String toString() {
    return 'Dashboard{${dashboardInfoString('configuration: $configuration')}}';
  }
}

class HomeDashboard extends Dashboard {
  bool hideDashboardToolbar;

  HomeDashboard(String title, this.hideDashboardToolbar) : super(title);

  HomeDashboard.fromJson(Map<String, dynamic> json)
      : hideDashboardToolbar = json['hideDashboardToolbar'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    json['hideDashboardToolbar'] = hideDashboardToolbar;
    return json;
  }

  @override
  String toString() {
    return 'HomeDashboard{${dashboardInfoString('hideDashboardToolbar: $hideDashboardToolbar, configuration: $configuration')}}';
  }
}

class HomeDashboardInfo {
  DashboardId? dashboardId;
  bool hideDashboardToolbar;

  HomeDashboardInfo(this.hideDashboardToolbar);

  HomeDashboardInfo.fromJson(Map<String, dynamic> json)
      : dashboardId = json['dashboardId'] != null
            ? DashboardId.fromJson(json['dashboardId'])
            : null,
        hideDashboardToolbar = json['hideDashboardToolbar'];

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{};
    if (dashboardId != null) {
      json['dashboardId'] = dashboardId!.toJson();
    }
    json['hideDashboardToolbar'] = hideDashboardToolbar;
    return json;
  }

  @override
  String toString() {
    return 'HomeDashboardInfo{dashboardId: $dashboardId, hideDashboardToolbar: $hideDashboardToolbar}';
  }
}
