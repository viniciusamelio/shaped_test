import 'package:shaped_test/core/base_domain/base_exception.dart';

class InvalidEmail extends BaseException {
  InvalidEmail({super.message = "E-mail inválido"});
}
