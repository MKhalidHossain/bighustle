import 'package:flutter/material.dart';

import 'package:flutter_bighustle/core/constants/app_routes.dart';
import 'package:flutter_bighustle/moduls/auth/presentation/widget/auth_ui.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AuthColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.08,
            vertical: size.height * 0.04,
          ),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.12),
              Center(
                child: AuthLogo(fontSize: size.width * 0.2),
              ),
              SizedBox(height: size.height * 0.02),
              Text(
                'Tagline goes here.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: (size.width * 0.05).clamp(16.0, 22.0),
                  fontWeight: FontWeight.w500,
                  color: AuthColors.textDark,
                ),
              ),
              const Spacer(),
              Text(
                'Signing up means you agree to our Terms &\nConditions and acknowledge our Privacy Policy.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: (size.width * 0.04).clamp(12.0, 16.0),
                  color: AuthColors.textMuted,
                ),
              ),
              SizedBox(height: size.height * 0.03),
              AuthPrimaryButton(
                size: size,
                label: 'Log In',
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.login);
                },
              ),
              SizedBox(height: size.height * 0.02),
              AuthSecondaryButton(
                size: size,
                label: 'Sign Up',
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.signup);
                },
              ),
              SizedBox(height: size.height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
