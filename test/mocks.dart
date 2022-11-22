import 'package:mocktail/mocktail.dart';
import 'package:shaped_test/core/base_domain/base_exception.dart';
import 'package:shaped_test/domain/repositories/auth_repository.dart';
import 'package:shaped_test/domain/repositories/examination_repository.dart';

class MockedException extends Mock implements BaseException {}

class MockedAuthRepository extends Mock implements AuthRepository {}

class MockedExaminationRepository extends Mock
    implements ExaminationRepository {}
