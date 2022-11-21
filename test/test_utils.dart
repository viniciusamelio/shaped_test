import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shaped_test/core/base_domain/base_exception.dart';

expectLeft<T>(Either result) {
  expect(result.isLeft(), isTrue);
  expect(result.fold((l) => l, (r) => null), isA<T>());
}

class MockedException extends Mock implements BaseException {}
