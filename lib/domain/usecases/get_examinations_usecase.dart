import 'package:fpdart/fpdart.dart';
import 'package:shaped_test/core/base_domain/base_usecase.dart';
import 'package:shaped_test/core/shared/types.dart';
import 'package:shaped_test/domain/entities/user.dart';
import 'package:string_validator/string_validator.dart';

import '../errors/examination_exceptions.dart';
import '../repositories/examination_repository.dart';

abstract class GetExaminationsUsecase
    implements BaseUsecase<User, ExaminationList> {}

class GetExaminationUsecaseImpl implements GetExaminationsUsecase {
  GetExaminationUsecaseImpl({
    required ExaminationRepository examinationRepository,
  }) : _examinationRepository = examinationRepository;

  final ExaminationRepository _examinationRepository;

  @override
  Output<ExaminationList> call(User input) async {
    if (!isEmail(input.email) || input.name.isEmpty) {
      return Left(
        InvalidUser(),
      );
    }

    final examinationListOrError = await _examinationRepository.get(input);
    return examinationListOrError;
  }
}
