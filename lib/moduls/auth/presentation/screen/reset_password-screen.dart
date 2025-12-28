import 'package:flutter/material.dart';

import 'package:flutter_bighustle/core/constants/app_routes.dart';
import 'package:flutter_bighustle/moduls/auth/presentation/widget/auth_ui.dart';

class ResetPasswordscreen extends StatefulWidget {
  final String? email;

  const ResetPasswordscreen({
    super.key,
    this.email,
  });

  @override
  State<ResetPasswordscreen> createState() => _ResetPasswordscreenState();
}

class _ResetPasswordscreenState extends State<ResetPasswordscreen> {
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
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
    final password = _passwordController.text.trim();
    final confirm = _confirmController.text.trim();

    if (password.isEmpty || confirm.isEmpty) {
      _showMessage('Please enter your new password.');
      return;
    }
    if (password != confirm) {
      _showMessage('Passwords do not match.');
      return;
    }

    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
      (route) => false,
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
                child: AuthLogo(fontSize: size.width * 0.16),
              ),
              SizedBox(height: size.height * 0.04),
              Text(
                'Create New Password',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: (size.width * 0.075).clamp(22.0, 30.0),
                  fontWeight: FontWeight.w700,
                  color: AuthColors.textDark,
                ),
              ),
              SizedBox(height: size.height * 0.015),
              Text(
                'Set a new password for your account.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: (size.width * 0.045).clamp(14.0, 18.0),
                  color: AuthColors.textMuted,
                ),
              ),
              SizedBox(height: size.height * 0.04),
              AuthTextField(
                size: size,
                controller: _passwordController,
                hintText: 'New Password',
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
                label: 'Reset Password',
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
