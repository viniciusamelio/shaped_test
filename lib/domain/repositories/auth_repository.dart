import 'package:shaped_test/core/shared/types.dart';
import 'package:shaped_test/domain/entities/auth_credential.dart';
import 'package:shaped_test/domain/entities/user.dart';

abstract class AuthRepository {
  Output<User> signin(AuthCredential credential);
}
