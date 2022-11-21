import 'package:shaped_test/core/base_domain/base_entity.dart';

class User implements BaseEntity {
  User({
    required this.name,
    required this.email,
  });

  final String name;
  final String email;
}
