import 'package:shaped_test/core/base_domain/base_usecase.dart';
import 'package:shaped_test/core/shared/types.dart';
import 'package:shaped_test/domain/entities/user.dart';

abstract class GetExaminationsUsecase
    implements BaseUsecase<User, ExaminationList> {}
