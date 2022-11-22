import 'package:flutter/cupertino.dart';
import 'package:shaped_test/core/base_presenter/base_states.dart';

abstract class BasePresenter extends ValueNotifier<BaseState> {
  BasePresenter(super.value);

  Future<void> loading() async {
    value = LoadingState();
  }
}

abstract class BaseState {}
