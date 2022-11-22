import 'package:shaped_test/core/shared/types.dart';
import 'package:shaped_test/domain/entities/user.dart';

abstract class ExaminationRepository {
  Output<ExaminationList> get(User input);
}
