import 'package:fpdart/fpdart.dart';
import 'package:shaped_test/domain/entities/user.dart';
import 'package:shaped_test/domain/entities/auth_credential.dart';
import 'package:shaped_test/core/shared/types.dart';
import 'package:shaped_test/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Output<User> signin(AuthCredential credential) async {
    await Future.delayed(const Duration(seconds: 2));

    return Right(
      User(name: "Vinicius Amélio", email: "vinicius.amelio@zoho.com"),
    );
  }
}
