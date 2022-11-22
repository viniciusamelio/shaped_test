import 'package:flutter/material.dart';
import 'package:shaped_test/core/base_presenter/base_states.dart';
import 'package:shaped_test/domain/entities/auth_credential.dart';
import 'package:shaped_test/presentation/controllers/auth_presenter.dart';
import 'package:shaped_test/presentation/services/di.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String route = "/login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final GlobalKey<FormState> _loginFormKey;

  String email = "";
  String password = "";

  late final AuthPresenter _authPresenter;

  @override
  void initState() {
    super.initState();
    _loginFormKey = GlobalKey<FormState>();
    _authPresenter = DIService.get();
    _authPresenter.addListener(() {
      if (_authPresenter.value is ErrorState) {
        final error = (_authPresenter.value as ErrorState).exception;
        showDialog(
          context: context,
          builder: (context) => Dialog(
            backgroundColor: Colors.red[300],
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                error.toString(),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _authPresenter.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Form(
        key: _loginFormKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              TextFormField(
                onSaved: (newValue) => email = newValue ?? "",
                decoration: const InputDecoration(
                  labelText: "E-mail",
                ),
              ),
              TextFormField(
                onSaved: (newValue) => password = newValue ?? "",
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Senha",
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ValueListenableBuilder(
                  valueListenable: _authPresenter,
                  builder: (context, state, loader) {
                    if (state is LoadingState) {
                      return loader!;
                    }
                    return MaterialButton(
                      onPressed: () async {
                        _loginFormKey.currentState!.save();
                        await _authPresenter.signIn(
                          AuthCredential(email: email, password: password),
                        );
                      },
                      color: Colors.deepOrangeAccent,
                      elevation: 0,
                      child: const Text("Entrar"),
                    );
                  },
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
