import 'package:thingsboard_pe_client/thingsboard_client.dart';

class ReportTemplateId extends EntityId {
  ReportTemplateId(String id,) : super(EntityType.REPORT_TEMPLATE, id);

  @override
  factory ReportTemplateId.fromJson(Map<String, dynamic> json) {
    return EntityId.fromJson(json) as ReportTemplateId;
  }

  @override
  String toString() {
    return 'ReportTemplateId {id: $id,}';
  }
}
