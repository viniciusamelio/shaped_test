import 'package:shaped_test/core/base_presenter/base_presenter.dart';

import '../../domain/entities/auth_credential.dart';

abstract class AuthPresenter extends BasePresenter {
  AuthPresenter(super.value);

  Future<void> signIn(AuthCredential input);
}
