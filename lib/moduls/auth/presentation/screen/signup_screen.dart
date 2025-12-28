import 'package:flutter/material.dart';

import 'package:flutter_bighustle/core/constants/app_routes.dart';
import 'package:flutter_bighustle/moduls/auth/presentation/widget/auth_ui.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _employeeController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _employeeController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _submit() {
    final name = _nameController.text.trim();
    final employeeId = _employeeController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirm = _confirmController.text.trim();

    if (name.isEmpty ||
        employeeId.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirm.isEmpty) {
      _showMessage('Please fill all fields.');
      return;
    }
    if (password != confirm) {
      _showMessage('Passwords do not match.');
      return;
    }

    Navigator.pushNamed(
      context,
      AppRoutes.emailVerify,
      arguments: email,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AuthColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.08,
            vertical: size.height * 0.04,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: size.height * 0.04),
              Center(
                child: AuthLogo(fontSize: size.width * 0.18),
              ),
              SizedBox(height: size.height * 0.04),
              Text(
                'Get Started',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: (size.width * 0.08).clamp(24.0, 34.0),
                  fontWeight: FontWeight.w700,
                  color: AuthColors.textDark,
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Text(
                'Register a new account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: (size.width * 0.045).clamp(14.0, 18.0),
                  color: AuthColors.textMuted,
                ),
              ),
              SizedBox(height: size.height * 0.04),
              AuthTextField(
                size: size,
                controller: _nameController,
                hintText: 'Full Name',
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: size.height * 0.02),
              AuthTextField(
                size: size,
                controller: _employeeController,
                hintText: 'Employee ID',
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: size.height * 0.02),
              AuthTextField(
                size: size,
                controller: _emailController,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.email],
              ),
              SizedBox(height: size.height * 0.02),
              AuthTextField(
                size: size,
                controller: _passwordController,
                hintText: 'Password',
                isPassword: true,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: size.height * 0.02),
              AuthTextField(
                size: size,
                controller: _confirmController,
                hintText: 'Confirm Password',
                isPassword: true,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(height: size.height * 0.04),
              AuthPrimaryButton(
                size: size,
                label: 'Sign up',
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
