// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:recipies_app/services/auth_service.dart';
import 'package:status_alert/status_alert.dart';

// ignore: use_key_in_widget_constructors
class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey();
  String? _username;
  String? _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SafeArea(child: _buildUI()),
    );
  }

  Widget _buildUI() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _title(),
          _loginForm(),
        ],
      ),
    );
  }

  Widget _title() {
    return const Text(
      'Recipe Book',
      style: TextStyle(
        fontSize: 35,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  Widget _loginForm() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.90,
      height: MediaQuery.of(context).size.height * 0.50,
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              initialValue: 'emilys',
              onSaved: (newValue) => setState(() => _username = newValue),
              validator: (value) => value!.isEmpty ? 'Please enter username' : null,
              decoration: const InputDecoration(
                hintText: 'Username',
              ),
            ),
            TextFormField(
              initialValue: 'emilyspass',
              onSaved: (newValue) => setState(() => _password = newValue),
              obscureText: true,
              validator: (value) =>
                  value!.isEmpty || value.length < 5 ? 'Please enter a valid password' : null,
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
            ),
            _loginButton(),
          ],
        ),
      ),
    );
  }

  Widget _loginButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.30,
      child: ElevatedButton(
        onPressed: () async {
          if (_loginFormKey.currentState?.validate() ?? false) {
            _loginFormKey.currentState?.save();
            bool result = await AuthService().login(_username!, _password!);

            if (result) {
              Navigator.pushReplacementNamed(context, '/home');
            } else {
              StatusAlert.show(
                context,
                duration: const Duration(seconds: 3),
                title: 'Login failed',
                subtitle: 'Please try again!',
                configuration: const IconConfiguration(icon: Icons.error_outline_outlined),
                maxWidth: 260,
              );
            }
          }
        },
        child: const Text('Login'),
      ),
    );
  }
}
