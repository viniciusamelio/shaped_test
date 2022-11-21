import 'package:shaped_test/core/base_domain/base_entity.dart';

class AuthCredential implements BaseEntity {
  AuthCredential({
    required this.emai,
    required this.password,
  });

  final String emai;
  final String password;
}
