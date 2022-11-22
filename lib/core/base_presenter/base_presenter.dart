import 'package:flutter/cupertino.dart';

abstract class BasePresenter extends ValueNotifier<BaseState> {
  BasePresenter(super.value);
}

abstract class BaseState {}
