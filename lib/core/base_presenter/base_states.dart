import 'package:shaped_test/core/base_presenter/base_presenter.dart';

class InitialState implements BaseState {}

class LoadingState implements BaseState {}

class SuccessState<T> implements BaseState {
  SuccessState({
    required this.data,
  });
  final T data;
}

class ErrorState<T extends Exception> implements BaseState {
  ErrorState({
    required this.exception,
  });

  final T exception;
}
