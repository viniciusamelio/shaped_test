import 'package:shaped_test/core/base_domain/base_usecase.dart';
import 'package:shaped_test/domain/entities/auth_credential.dart';
import 'package:shaped_test/domain/entities/user.dart';

abstract class SignInUsecase implements BaseUsecase<AuthCredential, User> {}
