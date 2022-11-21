import 'package:shaped_test/core/base_domain/base_entity.dart';

class AuthCredential implements BaseEntity {
  AuthCredential({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}
