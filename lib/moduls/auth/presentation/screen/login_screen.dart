import 'package:flutter/material.dart';

import 'package:flutter_bighustle/core/constants/app_routes.dart';
import 'package:flutter_bighustle/core/notifiers/snackbar_notifier.dart';
import 'package:flutter_bighustle/moduls/auth/controller/login_controller.dart';
import 'package:flutter_bighustle/moduls/auth/presentation/widget/auth_ui.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late final LoginsScreenController _controller;
  bool _initialized = false;
  bool _isLoading = false;

  void _onControllerUpdate() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      _controller = LoginsScreenController(SnackbarNotifier(context: context));
      _controller.addListener(_onControllerUpdate);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    if (_initialized) {
      _controller.removeListener(_onControllerUpdate);
      _controller.dispose();
    }
    super.dispose();
  }

  Future<void> _submit() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter email and password.')),
      );
      return;
    }

    setState(() => _isLoading = true);
    final success = await _controller.login(
      needVerification: () {
        Navigator.pushNamed(
          context,
          AppRoutes.emailVerify,
          arguments: email,
        );
      },
    );
    if (!mounted) {
      return;
    }
    setState(() => _isLoading = false);
    if (success) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    }
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
              SizedBox(height: size.height * 0.06),
              Center(
                child: AuthLogo(fontSize: size.width * 0.18),
              ),
              SizedBox(height: size.height * 0.05),
              Text(
                'Welcome',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: (size.width * 0.08).clamp(24.0, 34.0),
                  fontWeight: FontWeight.w700,
                  color: AuthColors.textDark,
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Text(
                'Please sign in to continue',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: (size.width * 0.045).clamp(14.0, 18.0),
                  color: AuthColors.textMuted,
                ),
              ),
              SizedBox(height: size.height * 0.04),
              AuthTextField(
                size: size,
                controller: _emailController,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.email],
                onChanged: (value) => _controller.email = value,
              ),
              SizedBox(height: size.height * 0.02),
              AuthTextField(
                size: size,
                controller: _passwordController,
                hintText: 'Password',
                isPassword: true,
                textInputAction: TextInputAction.done,
                autofillHints: const [AutofillHints.password],
                onChanged: (value) => _controller.password = value,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.forgetPassword);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: AuthColors.primary,
                  ),
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontSize: (size.width * 0.04).clamp(12.0, 16.0),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              AuthPrimaryButton(
                size: size,
                label: 'Login',
                onPressed: _controller.canSubmit && !_isLoading ? _submit : null,
                isLoading: _isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
