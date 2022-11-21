import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

export 'mocks.dart';

expectLeft<T>(Either result) {
  expect(result.isLeft(), isTrue);
  expect(result.fold((l) => l, (r) => null), isA<T>());
}
