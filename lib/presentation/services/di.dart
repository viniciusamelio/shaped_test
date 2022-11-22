import 'package:kiwi/kiwi.dart';
import 'package:shaped_test/domain/repositories/auth_repository.dart';
import 'package:shaped_test/domain/repositories/examination_repository.dart';
import 'package:shaped_test/domain/usecases/get_examinations_usecase.dart';
import 'package:shaped_test/domain/usecases/signin_usecase.dart';
import 'package:shaped_test/infra/repositories/auth_repository.dart';
import 'package:shaped_test/infra/repositories/examination_repository.dart';

abstract class DIService {
  static final KiwiContainer _container = KiwiContainer();

  void init() {
    loginInjections();
    examinationsInjections();
  }

  void loginInjections() {
    _container.registerFactory<AuthRepository>(
      (container) => AuthRepositoryImpl(),
    );
    _container.registerFactory<SignInUsecase>(
      (container) => SignInUsecaseImpl(
        authRepository: container(),
      ),
    );
  }

  void examinationsInjections() {
    _container.registerFactory<ExaminationRepository>(
      (container) => ExaminationRepositoryImpl(),
    );
    _container.registerFactory<GetExaminationsUsecase>(
      (container) => GetExaminationUsecaseImpl(
        examinationRepository: container(),
      ),
    );
  }

  T get<T>() => _container<T>();
}
