import 'package:shaped_test/core/base_domain/base_exception.dart';

class InvalidUser extends BaseException {
  InvalidUser({super.message = "Usuário inválido"});
}
