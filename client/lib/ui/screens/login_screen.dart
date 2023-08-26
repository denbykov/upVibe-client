import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'enter_server_screen.dart';

import '../components/app_scaffold.dart';
import '../components/app_page_route.dart';

import '../../models/authentication_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var form = SizedBox(
        width: 300,
        child: Form(
            key: _loginFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                makeLabel(context),
                makeUsernameField(),
                makePasswordField(),
                makeButtonsRow(context)
              ],
            )));

    return AppScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
              child: form)
        ],
      ),
    );
  }

  Padding makeButtonsRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 56,
          ),
          Center(
            child: SizedBox(
              width: 100,
              child: ElevatedButton(
                onPressed: _login,
                child: const Text('Login'),
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Ink(
              decoration: ShapeDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                shape: const CircleBorder(),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.lan,
                ),
                tooltip: 'Enter server',
                onPressed: () {
                  Navigator.of(context).push(AppPageRoute(
                      builder: (context) => const EnterServerScreen()));
                },
              )),
        ],
      ),
    );
  }

  Widget _makeLoginDialogContent(BuildContext context, List<Widget> children) {
    return SizedBox(
      height: 180,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround, children: children),
    );
  }

  Future<void> _makeLoginDialog(BuildContext context, Future<bool> future) {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(0))),
            content: FutureBuilder<bool>(
              future: future,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return _makeLoginDialogContent(context, [
                      SpinKitFoldingCube(
                        color: Theme.of(context).colorScheme.primary,
                        size: 50,
                      ),
                    ]);
                  default:
                    if (snapshot.hasError) {
                      return _makeLoginDialogContent(context, [
                        const SizedBox(
                          height: 40,
                        ),
                        const Text('Login failed'),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: ElevatedButton(
                            style: TextButton.styleFrom(
                              textStyle: Theme.of(context).textTheme.labelLarge,
                            ),
                            child: const Text('Ok'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        )
                      ]);
                    } else {
                      if (snapshot.data!) {
                        return _makeLoginDialogContent(context, [
                          const SizedBox(
                            height: 40,
                          ),
                          const Text('Login succeeded'),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: ElevatedButton(
                              style: TextButton.styleFrom(
                                textStyle:
                                    Theme.of(context).textTheme.labelLarge,
                              ),
                              child: const Text('Ok'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          )
                        ]);
                      } else {
                        return _makeLoginDialogContent(context, [
                          const SizedBox(
                            height: 40,
                          ),
                          const Text('Login failed'),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: ElevatedButton(
                              style: TextButton.styleFrom(
                                textStyle:
                                    Theme.of(context).textTheme.labelLarge,
                              ),
                              child: const Text('Ok'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          )
                        ]);
                      }
                    }
                }
              },
            ));
      },
    );
  }

  Future<void> _login() async {
    if (!_loginFormKey.currentState!.validate()) {
      return;
    }

    final model = AuthenticationModel();
    _makeLoginDialog(
        context,
        model.login(
            username: _usernameController.text,
            password: _passwordController.text));
  }

  Align makeLabel(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 35, bottom: 8, left: 16),
        child: SelectableText('Login',
            textAlign: TextAlign.right,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Padding makePasswordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextFormField(
        obscureText: true,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.only(),
          hintText: 'Password',
        ),
        controller: _passwordController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter the password';
          }
          return null;
        },
      ),
    );
  }

  Padding makeUsernameField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextFormField(
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.only(),
          hintText: 'Username',
        ),
        controller: _usernameController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your username';
          }
          return null;
        },
      ),
    );
  }
}
