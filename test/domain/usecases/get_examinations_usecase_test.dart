import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shaped_test/domain/entities/examination.dart';
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

  final input = User(name: "Amélio", email: faker.internet.email());

  group("GetExaminationsUsecase: ", () {
    setUp(() {
      examinationRepository = MockedExaminationRepository();
      sut = GetExaminationUsecaseImpl(
        examinationRepository: examinationRepository,
      );
      registerFallbackValue(input);
    });

    test(
      "sut should return an InvalidUser exception when user email isnt valid",
      () async {
        final result = await sut(
          User(name: "Vinicius", email: "aa.com"),
        );

        expectLeft<InvalidUser>(result);
      },
    );

    test(
      "sut should return an InvalidUser exception when user name is empty",
      () async {
        final result = await sut(
          User(
            name: "",
            email: faker.internet.email(),
          ),
        );

        expectLeft<InvalidUser>(result);
      },
    );

    test("sut should return left when repository does so", () async {
      when(
        () => examinationRepository.get(
          any(),
        ),
      ).thenAnswer(
        (invocation) async => Left(
          MockedException(),
        ),
      );

      final result = await sut(input);

      expectLeft<MockedException>(result);
    });

    test("sut should return right when repository does so", () async {
      when(
        () => examinationRepository.get(
          any(),
        ),
      ).thenAnswer(
        (invocation) async => Right(
          [
            Examination(
              id: 1,
              patientName: faker.person.name(),
              status: ExaminationStatus.finished,
            ),
            Examination(
              id: 2,
              patientName: faker.person.name(),
              status: ExaminationStatus.processing,
            ),
          ],
        ),
      );

      final result = await sut(input);

      expect(result.isRight(), isTrue);
    });
  });
}
