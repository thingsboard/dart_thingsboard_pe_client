import 'has_customer_id.dart';
import 'has_owner_id.dart';
import 'has_name.dart';
import 'id/has_id.dart';
import 'id/entity_id.dart';
import 'tenant_entity.dart';

abstract class GroupEntity<I extends EntityId>
    implements HasId<I>, HasName, TenantEntity, HasCustomerId, HasOwnerId {}
