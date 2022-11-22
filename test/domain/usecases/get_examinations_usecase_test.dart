import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shaped_test/domain/entities/user.dart';
import 'package:shaped_test/core/shared/types.dart';
import 'package:shaped_test/domain/errors/examination_exceptions.dart';
import 'package:shaped_test/domain/repositories/examination_repository.dart';
import 'package:shaped_test/domain/usecases/get_examinations_usecase.dart';
import 'package:string_validator/string_validator.dart';

import '../../test_utils.dart';

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

void main() {
  late GetExaminationsUsecase sut;
  late ExaminationRepository examinationRepository;

  group("GetExaminationsUsecase: ", () {
    setUp(() {
      examinationRepository = MockedExaminationRepository();
      sut = GetExaminationUsecaseImpl(
        examinationRepository: examinationRepository,
      );
    });

    test(
        "sut should return an InvalidUser exception when user email isnt valid",
        () async {
      final result = await sut(
        User(name: "Vinicius", email: "aa.com"),
      );

      expectLeft<InvalidUser>(result);
    });
  });
}
