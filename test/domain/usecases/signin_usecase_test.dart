import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shaped_test/domain/entities/auth_credential.dart';
import 'package:shaped_test/core/shared/types.dart';
import 'package:shaped_test/domain/entities/user.dart';
import 'package:shaped_test/domain/errors/auth_exceptions.dart';
import 'package:shaped_test/domain/repositories/auth_repository.dart';
import 'package:shaped_test/domain/usecases/signin_usecase.dart';
import 'package:string_validator/string_validator.dart';

import '../../test_utils.dart';

class MockedAuthRepository extends Mock implements AuthRepository {}

class SignInUsecaseImpl implements SignInUsecase {
  SignInUsecaseImpl({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  final AuthRepository _authRepository;

  @override
  Output<User> call(AuthCredential input) async {
    if (!isEmail(input.email)) {
      return Left(InvalidEmail());
    } else if (input.password.isEmpty) {
      return Left(InvalidPassword());
    }
    final userOrError = await _authRepository.signin(input);
    return userOrError;
  }
}

void main() {
  late SignInUsecase sut;
  late AuthRepository authRepository;

  final input = AuthCredential(
    email: faker.internet.email(),
    password: "aRandomPass",
  );

  group("SignInUsecase: ", () {
    setUpAll(() {
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
        (when(
          () => authRepository.signin(
            any(),
          ),
        )).thenAnswer(
          (invocation) async => Left(
            MockedException(),
          ),
        );

        final result = await sut(input);

        expectLeft<MockedException>(result);
      },
    );
  });
}
