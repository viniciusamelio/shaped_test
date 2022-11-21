import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shaped_test/domain/entities/auth_credential.dart';
import 'package:shaped_test/domain/entities/user.dart';
import 'package:shaped_test/domain/errors/auth_exceptions.dart';
import 'package:shaped_test/domain/repositories/auth_repository.dart';
import 'package:shaped_test/domain/usecases/signin_usecase.dart';

import '../../test_utils.dart';

void main() {
  late SignInUsecase sut;
  late AuthRepository authRepository;

  final input = AuthCredential(
    email: faker.internet.email(),
    password: "aRandomPass",
  );

  group("SignInUsecase: ", () {
    setUp(() {
      authRepository = MockedAuthRepository();
      sut = SignInUsecaseImpl(
        authRepository: authRepository,
      );
      registerFallbackValue(
        input,
      );
    });

    test(
      "sut should return an InvalidEmail exception when input.email is an invalid email string",
      () async {
        final result = await sut(
          AuthCredential(
            email: "",
            password: "",
          ),
        );

        expectLeft<InvalidEmail>(
          result,
        );
        verifyNever(() => authRepository.signin(any())).called(0);
      },
    );
    test(
      "sut should return an InvalidPassword exception when input.password is an empty string",
      () async {
        final result = await sut(
          AuthCredential(
            email: faker.internet.email(),
            password: "",
          ),
        );

        expectLeft<InvalidPassword>(
          result,
        );
      },
    );

    test(
      "sut should return left when repository does so",
      () async {
        when(
          () => authRepository.signin(
            any(),
          ),
        ).thenAnswer(
          (invocation) async => Left(
            MockedException(),
          ),
        );

        final result = await sut(input);

        expectLeft<MockedException>(result);
      },
    );

    test(
      "sut should return right when repository does so",
      () async {
        when(
          () => authRepository.signin(
            any(),
          ),
        ).thenAnswer(
          (invocation) async => Right(
            User(
              name: faker.person.name(),
              email: faker.internet.email(),
            ),
          ),
        );

        final result = await sut(input);

        expect(result.isRight(), isTrue);
        verify(() => authRepository.signin(any())).called(1);
      },
    );
  });
}
