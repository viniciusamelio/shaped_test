import 'package:shaped_test/core/base_presenter/base_states.dart';
import 'package:shaped_test/domain/entities/auth_credential.dart';
import 'package:shaped_test/domain/usecases/signin_usecase.dart';
import 'package:shaped_test/presentation/controllers/auth_presenter.dart';

import '../../domain/entities/user.dart';

class AuthController extends AuthPresenter {
  AuthController({
    required SignInUsecase signInUsecase,
  })  : _signInUsecase = signInUsecase,
        super(InitialState());

  late final SignInUsecase _signInUsecase;

  @override
  Future<void> signIn(AuthCredential input) async {
    loading();

    final result = await _signInUsecase(input);

    result.fold(
      (l) => value = ErrorState<Exception>(exception: l),
      (r) => value = SuccessState<User>(data: r),
    );
  }
}
