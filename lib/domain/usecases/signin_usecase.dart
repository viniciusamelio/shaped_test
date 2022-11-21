import 'package:fpdart/fpdart.dart';
import 'package:shaped_test/core/base_domain/base_usecase.dart';
import 'package:shaped_test/domain/entities/auth_credential.dart';
import 'package:shaped_test/domain/entities/user.dart';
import 'package:string_validator/string_validator.dart';

import '../../core/shared/types.dart';
import '../errors/auth_exceptions.dart';
import '../repositories/auth_repository.dart';

abstract class SignInUsecase implements BaseUsecase<AuthCredential, User> {}

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
