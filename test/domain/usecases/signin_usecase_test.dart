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
    }
    final userOrError = await _authRepository.signin(input);
    return userOrError;
  }
}

void main() {
  late SignInUsecase sut;
  late AuthRepository authRepository;

  group("SignInUsecase: ", () {
    setUpAll(() {
      authRepository = MockedAuthRepository();
      sut = SignInUsecaseImpl(
        authRepository: authRepository,
      );
      registerFallbackValue(
        AuthCredential(
          email: faker.internet.email(),
          password: "aRandomPass",
        ),
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

      expect(result.isLeft(), isTrue);
      expect(result.fold((l) => l, (r) => null), isA<InvalidEmail>());
      verifyNever(() => authRepository.signin(any())).called(0);
    });
  });
}
