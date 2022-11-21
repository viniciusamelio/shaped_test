import 'package:shaped_test/core/base_domain/base_entity.dart';
import 'package:shaped_test/core/shared/types.dart';

abstract class BaseUsecase<I extends BaseEntity, O> {
  Output<O> call(I input);
}
