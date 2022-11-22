import 'package:kiwi/kiwi.dart';
import 'package:shaped_test/domain/repositories/auth_repository.dart';
import 'package:shaped_test/domain/repositories/examination_repository.dart';
import 'package:shaped_test/domain/usecases/get_examinations_usecase.dart';
import 'package:shaped_test/domain/usecases/signin_usecase.dart';
import 'package:shaped_test/infra/repositories/auth_repository.dart';
import 'package:shaped_test/infra/repositories/examination_repository.dart';
import 'package:shaped_test/presentation/controllers/auth_controller.dart';
import 'package:shaped_test/presentation/controllers/auth_presenter.dart';

abstract class DIService {
  static final KiwiContainer _container = KiwiContainer();

  static void init() {
    loginInjections();
    examinationsInjections();
  }

  static void loginInjections() {
    _container.registerFactory<AuthRepository>(
      (container) => AuthRepositoryImpl(),
    );
    _container.registerFactory<SignInUsecase>(
      (container) => SignInUsecaseImpl(
        authRepository: container(),
      ),
    );
    _container.registerFactory<AuthPresenter>(
      (container) => AuthController(
        signInUsecase: container(),
      ),
    );
  }

  static void examinationsInjections() {
    _container.registerFactory<ExaminationRepository>(
      (container) => ExaminationRepositoryImpl(),
    );
    _container.registerFactory<GetExaminationsUsecase>(
      (container) => GetExaminationUsecaseImpl(
        examinationRepository: container(),
      ),
    );
  }

  static T get<T>() => _container<T>();
}
