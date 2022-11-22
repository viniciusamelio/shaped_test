import 'package:flutter/material.dart';
import 'package:shaped_test/presentation/app.dart';
import 'package:shaped_test/presentation/services/di.dart';

void main() async {
  DIService.init();
  runApp(const App());
}
